(function($) {

  $.fn.railsSortable = function(options) {
    var defaults = {
      axis: 'y',
      scroll: 'true'
    };

    var setting = $.extend(defaults, options);
    setting["update"] = function() {
      params = $(this).sortable('serialize')
      if(!!this.dataset.sortcolumn) {
        params += ("&sortable_column=" + this.dataset.sortcolumn)
      }

      $.post("/sortable/reorder", params)
    }

    this.sortable(setting);
  };

})(jQuery);