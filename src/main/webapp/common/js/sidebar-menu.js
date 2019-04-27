$.sidebarMenu = function(menu) {
  var animationSpeed = 300,
    //subMenuSelector = '.sidebar-submenu';
      subMenuSelector = '.collapse';

  $('#sidebarnav').on('click', 'li a', function(e) {
    var $this = $(this);

    var checkElement = $this.next();

    if (checkElement.is(subMenuSelector) && checkElement.is(':visible')) {

      checkElement.slideUp(animationSpeed, function() {
        checkElement.removeClass('menu-open');
      });
     // checkElement.parent("li").removeClass("active");
    }

    //If the menu is not visible
    else if ((checkElement.is(subMenuSelector)) && (!checkElement.is(':visible'))) {
      //Get the parent menu
      var parent = $this.parents('ul').first();
      //Close all open menus within the parent
      var ul = parent.find('ul:visible').slideUp(animationSpeed);
      //Remove the menu-open class from the parent
      ul.removeClass('menu-open');
      //Get the parent li
      var parent_li = $this.parent("li");

      //Open the target menu and add the menu-open class
      checkElement.slideDown(animationSpeed, function() {
        //Add the class active to the parent li
        checkElement.addClass('menu-open');
        //parent.find('li.active').removeClass('active');
        //parent_li.addClass('active');
      });
    }
    //if this isn't a link, prevent the page from being redirected
    if (checkElement.is(subMenuSelector)) {
      e.preventDefault();
    }
  });
}

$.sidebarSubMenu = function() {

  $('.sidebar-item').on('click', 'li', function(e) {
    var subMenu = $('.collapse');
    //console.log($this);
    subMenu.find('li').removeClass('active');
    subMenu.find('li').find('a').removeClass('active');

    var $this = $(this);
    $this.find('a').addClass('active');
    var checkElement = $this.next();

    checkElement.parent("li").removeClass('active');

  });
}
