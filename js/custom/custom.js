function clearInput(a) {
	if (a.value == "") {
		a.value = "Search..."
	}
}
function defaultInput(a) {
	if (a.value == "Search...") {
		a.value = ""
	}
}
jQuery(document).ready(function(a) {
	a("ul.sf-menu").superfish({
		animation: {
			height: "show"
		},
		delay: 800,
		autoArrows: false
	});
	a("ul.sf-menu>li>ul li").hover(function() {
		a(this).children("a").children("span").stop().animate({
			marginLeft: "3"
		}, "fast")
	}, function() {
		a(this).children("a").children("span").stop().animate({
			marginLeft: "0"
		}, "fast")
	});
	a("ul.tabs").tabs("div.panes > div", {
		effect: "fade"
	});
	var b = a("ul#portfolio-list");
	for (var c = 0; c < a("ul#portfolio-list li").length; c++) {
		a("ul#portfolio-list li:eq(" + c + ")").attr("id", "unique_item" + c)
	}
	var d = b.clone();
	a("#portfolio-filter a").click(function(b) {
		if (a(this).attr("rel") == "all") {
			var c = d.find("li")
		} else {
			var c = d.find("li." + a(this).attr("rel"))
		}
		a("ul#portfolio-list").quicksand(c, {
			duration: 500,
			attribute: function(b) {
				return a(b).attr("id")
			}
		}, function() {
			thumbsFunctions()
		});
		b.preventDefault()
	});
	a(".toggle-container").hide();
	a(".toggle-trigger").click(function() {
		a(this).toggleClass("active").next().slideToggle("slow");
		return false
	});
    
    //menu current active
    var url = window.location.pathname,
        urlRegExp = new RegExp(url.replace(/\/$/,''));    
        jQuery('#nav li a').each(function(){
            if(urlRegExp.test(this.href)){
                jQuery(this).addClass('active');
            }
        });
})