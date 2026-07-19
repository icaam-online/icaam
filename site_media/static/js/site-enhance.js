/* =====================================================================
   ICAAM site enhancement
   Builds a mobile-only top bar with two buttons:
     - Left  : main menu   (clones the top Bootstrap navbar list)
     - Right : quick links (clones the right-hand side panel list)
   Both open as slide-in drawers. Nothing here runs any differently on
   desktop -- the injected elements are hidden by CSS above 767px.
   Each page keeps its own navigation markup; this script only mirrors it.
   ===================================================================== */
(function () {
	"use strict";

	function ready(fn) {
		if (document.readyState !== "loading") {
			fn();
		} else {
			document.addEventListener("DOMContentLoaded", fn);
		}
	}

	function el(tag, className, html) {
		var node = document.createElement(tag);
		if (className) node.className = className;
		if (html != null) node.innerHTML = html;
		return node;
	}

	ready(function () {
		var body = document.body;
		if (!body || document.querySelector(".m-topbar")) return; // guard against double init

		// --- Source lists on this page ---
		var mainMenu = document.querySelector(".navbar-collapse .navbar-nav")
			|| document.querySelector(".navbar-nav");
		var sideMenu = document.querySelector(".panel.tree ul")
			|| document.querySelector(".navlist-menu-level-0");

		// --- Overlay ---
		var overlay = el("div", "m-overlay");

		// --- Top bar ---
		var topbar = el("div", "m-topbar");

		var leftBtn = el("button", "m-btn",
			'<span class="m-bars"></span><span class="m-btn-label">Menu</span>');
		leftBtn.type = "button";
		leftBtn.setAttribute("aria-label", "Open main menu");

		var title = el("span", "m-title", "ICAAM 2026");

		var rightBtn = el("button", "m-btn",
			'<span class="m-bars"></span><span class="m-btn-label">Links</span>');
		rightBtn.type = "button";
		rightBtn.setAttribute("aria-label", "Open quick links");

		topbar.appendChild(leftBtn);
		topbar.appendChild(title);
		topbar.appendChild(rightBtn);

		// --- Drawer builder ---
		function buildDrawer(side, headText, sourceUl) {
			var drawer = el("div", "m-drawer " + side);
			var head = el("div", "m-drawer-head");
			head.appendChild(el("span", null, headText));
			var closeBtn = el("button", "m-close", "&times;");
			closeBtn.type = "button";
			closeBtn.setAttribute("aria-label", "Close");
			head.appendChild(closeBtn);
			drawer.appendChild(head);

			var list = el("ul");
			if (sourceUl) {
				var items = sourceUl.children;
				for (var i = 0; i < items.length; i++) {
					if (items[i].tagName !== "LI") continue;
					var li = items[i].cloneNode(true);
					// A list item with no link that is not a divider becomes a text label
					if (!li.querySelector("a") && li.className.indexOf("menu-divider") === -1) {
						li.className = (li.className ? li.className + " " : "") + "m-text";
					}
					list.appendChild(li);
				}
			}
			drawer.appendChild(list);

			closeBtn.addEventListener("click", closeAll);
			return drawer;
		}

		var leftDrawer = buildDrawer("m-left", "Menu", mainMenu);
		var rightDrawer = buildDrawer("m-right", "Quick Links", sideMenu);

		// --- Open / close logic ---
		function closeAll() {
			leftDrawer.classList.remove("m-open");
			rightDrawer.classList.remove("m-open");
			overlay.classList.remove("m-open");
			body.classList.remove("m-nav-open");
		}
		function openDrawer(drawer) {
			var wasOpen = drawer.classList.contains("m-open");
			closeAll();
			if (!wasOpen) {
				drawer.classList.add("m-open");
				overlay.classList.add("m-open");
				body.classList.add("m-nav-open");
			}
		}

		leftBtn.addEventListener("click", function () { openDrawer(leftDrawer); });
		rightBtn.addEventListener("click", function () { openDrawer(rightDrawer); });
		overlay.addEventListener("click", closeAll);
		document.addEventListener("keydown", function (e) {
			if (e.key === "Escape" || e.keyCode === 27) closeAll();
		});
		// Close when a real navigation link is tapped
		[leftDrawer, rightDrawer].forEach(function (d) {
			d.addEventListener("click", function (e) {
				var a = e.target.closest ? e.target.closest("a") : null;
				if (a && a.getAttribute("href")) closeAll();
			});
		});

		// --- Insert into the page (top bar first thing in the body) ---
		body.insertBefore(topbar, body.firstChild);
		body.appendChild(overlay);
		body.appendChild(leftDrawer);
		body.appendChild(rightDrawer);
	});
})();
