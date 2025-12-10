
jQuery(function($) {

    // The dropdown list for adding a new page contains URLs for each
    // model - redirect when selected.
    $('.addlist').change(function() {
        // Ensure the branch is saved as open when adding to it so that
        // the new branch will be visible directly after saving.
        var id = $(this).attr('id');
        if (id) {
            toggleID(true, id.split('-')[1]);
        }
        var addUrl = this[this.selectedIndex].value;
        if (addUrl) {
            location.href = addUrl;
        }
        this.selectedIndex = 0;
        return true;
    });

});