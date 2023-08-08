$(document).ready(function myfunction() {
    $('.carousel').carousel({
        interval: 5000
    })
    $('#myCarousel').on('slid.bs.carousel', function (item) {

        var index = $('.carousel .active').index('.carousel .item');


        var items = $("ul.carousel-nav > li");
        for (var i = 0; i < items.length; i++) {
            if (i == index) {
                $(items[i]).addClass("active");
            } else {
                $(items[i]).removeClass("active");
            }
        }
    });

});

function carouselpause() {
    $('.carousel').carousel('pause');
};
