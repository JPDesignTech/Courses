$(window).on("load", function() {
    $(".loader .inner").fadeOut(500, function() {
        $(".loader").fadeOut(750);
    });

    // https://github.com/metafizzy/isotope
    $(".items").isotope({
        filter: '*',
        animationOptions: {
            duration: 1500,
            easing: 'linear',
            queue: false
        }
    })
})


$(document).ready(function() {
    // Superslides is a full screen, hardware accelerated slider for jQuery. 
    // https://github.com/nicinabox/superslides
    $('#slides').superslides({
        animation: 'fade', // [string] slide or fade. This matches animations defined by fx engine. 
        play: 6000, // [number] Milliseconds before progressing to next slide automatically. Use a falsey value to disable. 
        pagination: false // [boolean] Generate pagination. Add an id to your slide to use custom pagination on that slide.
    });

    // https://github.com/mattboldt/typed.js/
    var typed = new Typed(".typed", {
        strings: ["Computer Engineer, MSCpE.", "Software Developer.", "Full-Stack Engineer."],
        typeSpeed: 70,
        loop: true,
        startDelay: 1000,
        showCursor: false
    });

    // https://github.com/OwlCarousel2/OwlCarousel2
    $('.owl-carousel').owlCarousel({
        loop: true,
        items: 4,
        responsive: {
            0: {
                items: 1
            },
            480: {
                items: 2
            },
            768: {
                items: 3
            },
            938: {
                items: 4
            }
        }
    })

    var skillsTopOffset = $(".skillsClass").offset().top;
    var infoTopOffset = $(".infoClass").offset().top;
    var countUpFinished = false;
    $(window).scroll(function() {
        if (this.window.pageYOffset > skillsTopOffset - $(window).height() + 200) {
            // https://github.com/rendro/easy-pie-chart
            $('.chart').easyPieChart({
                easing: 'easeInOut',
                barColor: '#ffffff',
                trackColor: '#333333',
                scaleColor: false,
                lineWidth: 7,
                size: 152,

                onStep: function(from, to, percent) {
                    $(this.el).find('.percent').text(Math.round(percent));
                }
            });
        }

        if (!countUpFinished && this.window.pageYOffset > infoTopOffset - $(window).height() + 200) {
            // https://github.com/inorganik/CountUp.js
            $(".counter").each(function() {
                var element = $(this);
                var endVal = parseInt(element.text());
                element.countup(endVal);
            })

            countUpFinished = true;
        }
    })

    // https://github.com/fancyapps/fancybox
    $("[data-fancybox]").fancybox();

    $("#filters a").click(function() {
        $("#filters .current").removeClass("current");
        $(this).addClass("current");

        var selector = $(this).attr("data-filter");

        $(".items").isotope({
            filter: selector,
            animationOptions: {
                duration: 1500,
                easing: 'linear',
                queue: false
            }
        });

        return false;
    });

    $('#navigation li a').click(function(e) {
        e.preventDefault();

        var targetElement = $(this).attr("href");
        var targetPosition = $(targetElement).offset().top;
        $("html, body").animate({
            scrollTop: targetPosition - 50
        }, "slow")
    });

    const nav = $("#navigation");
    const navTop = nav.offset().top;
    $(window).on("scroll", stickyNavgation);

    function stickyNavgation() {
        var body = $("body");

        if ($(window).scrollTop() >= navTop) {
            body.css("padding-top", nav.outerHeight() + "px");
            body.addClass("fixedNav");
        } else {
            body.css("padding-top", 0);
            body.removeClass("fixedNav");
        }

    }
});