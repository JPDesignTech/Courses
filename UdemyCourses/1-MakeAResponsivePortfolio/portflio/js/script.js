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

    $(window).scroll(function() {
        if (this.window.pageYOffset > skillsTopOffset - $(window).height() + 200) {
            // https://github.com/rendro/easy-pie-chart
            $('.chart').easyPieChart({
                easing: 'easeInOut',
                barColor: '#ffffff',
                trackColor: 'black',
                scaleColor: false,
                lineWidth: 4,
                size: 152,
                onStep: function(from, to, percent) {
                    $(this.el).find('.percent').text(Math.round(percent));
                }
            });
        }
    })

});