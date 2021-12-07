'use strict'

//Preloader
var preloader = $('#spinner-wrapper');
$(window).on('load', function () {
    var preloaderFadeOutTime = 500;

    function hidePreloader() {
        preloader.fadeOut(preloaderFadeOutTime);
    }
    hidePreloader();
});

function Grow(e) {
    e.style.height = 0;
    e.style.height = e.scrollHeight + 'px';
}

function callMe(tbox, fid, uid, ChatBody) {
    if (fid != null && $.trim($(tbox).val()) != "") {
        var dataValue = '{ \'FID\': \'' + fid + '\', \'UID\': \'' + uid + '\', \'Content\': "' + $.trim($(tbox).val()) + '" }';
        $.ajax({
            type: "POST",
            url: "../WS/WS_Chat.asmx/AddNewMessage",
            data: dataValue,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $(ChatBody).append(response.d);
                $(tbox).val('');
                //console.log(response.d);
            },
            error: function (response) {
                console.log(response.responseText);
            }
        });
    }
}

function GetAllUnReadMessages(ChatBody, fid, uid){
    if (fid != null) {
        var dataValue = '{ \'FID\': \'' + fid + '\', \'UID\': \'' + uid + '\'}';
        $.ajax({
            type: "POST",
            url: "../WS/WS_Chat.asmx/AllUnread",
            data: dataValue,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d != "") {
                    $(ChatBody).append(response.d);
                }
            },
            error: function (response) {
                console.log(response.responseText);
            }
        });
    }
}

function EditMobile(UID, Mobile) {
    var dataValue = '{ \'Mobile\': \'' + $(Mobile).val() + '\' , \'Uid\': \'' + UID + '\'}';
    $.ajax({
        type: "POST",
        url: "../WS/EditPersonal.asmx/EditMobile",
        data: dataValue,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            //console.log(response.d);
        },
        error: function (response) {
            console.log(response.responseText);
        }
    });
}

function FN_EditBirthday(UID, Day, Month, Year) {
    var dataValue = '{ \'Day\': \'' + $(Day).val() + '\' , \'Month\': \'' + $(Month).val() + '\' , \'Year\': \'' + $(Year).val() + '\' , \'Uid\': \'' + UID + '\'}';
    $.ajax({
        type: "POST",
        url: "../WS/EditPersonal.asmx/EditBirthday",
        data: dataValue,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            //console.log(response.d);
        },
        error: function (response) {
            console.log(response.responseText);
        }
    });
}

function FN_EditPassword(UID, OldPass, NewPass) {
    var dataValue = '{ \'OldPass\': \'' + $(OldPass).val() + '\' , \'NewPass\': \'' + $(NewPass).val() + '\' , \'Uid\': \'' + UID + '\'}';
    $.ajax({
        type: "POST",
        url: "../WS/EditPersonal.asmx/EditPassword",
        data: dataValue,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            alert(response.d);
        },
        error: function (response) {
            console.log(response.responseText);
        }
    });
}

function ShowDateMessage(e) {
    var c = e.children[2];
    if (c.style.visibility == "visible") {
        c.style.visibility = "hidden";
        c.style.opacity = "0";
    }
    else {
        c.style.visibility = "visible";
        c.style.opacity = "1";
    }
}

jQuery(document).ready(function ($) {

    //Incremental Coutner
    if ($.isFunction($.fn.incrementalCounter))
        $("#incremental-counter").incrementalCounter();

    //For Trigering CSS3 Animations on Scrolling
    if ($.isFunction($.fn.appear))
        $(".slideDown, .slideUp").appear();

    $(".slideDown, .slideUp").on('appear', function (event, $all_appeared_elements) {
        $($all_appeared_elements).addClass('appear');
    });

    //For Header Appearing in Homepage on Scrolling
    var lazy = $('#header.lazy-load')

    $(window).on('scroll', function () {
        if ($(this).scrollTop() > 200) {
            lazy.addClass('visible');
        } else {
            lazy.removeClass('visible');
        }
    });

    //Initiate Scroll Styling
    if ($.isFunction($.fn.scrollbar))
        $('.scrollbar-wrapper').scrollbar();

    if ($.isFunction($.fn.masonry)) {

        // fix masonry layout for chrome due to video elements were loaded after masonry layout population
        // we are refreshing masonry layout after all video metadata are fetched.
        var vElem = $('.img-wrapper video');
        var videoCount = vElem.length;
        var vLoaded = 0;

        vElem.each(function (index, elem) {

            //console.log(elem, elem.readyState);

            if (elem.readyState) {
                vLoaded++;

                if (count == vLoaded) {
                    $('.js-masonry').masonry('layout');
                }

                return;
            }

            $(elem).on('loadedmetadata', function () {
                vLoaded++;
                //console.log('vLoaded',vLoaded, this);
                if (videoCount == vLoaded) {
                    $('.js-masonry').masonry('layout');
                }
            })
        });


        // fix masonry layout for chrome due to image elements were loaded after masonry layout population
        // we are refreshing masonry layout after all images are fetched.
        var $mElement = $('.img-wrapper img');
        var count = $mElement.length;
        var loaded = 0;

        $mElement.each(function (index, elem) {

            if (elem.complete) {
                loaded++;

                if (count == loaded) {
                    $('.js-masonry').masonry('layout');
                }

                return;
            }

            $(elem).on('load', function () {
                loaded++;
                if (count == loaded) {
                    $('.js-masonry').masonry('layout');
                }
            })
        });

    } // end of `if masonry` checking


    //Fire Scroll and Resize Event
    $(window).trigger('scroll');
    $(window).trigger('resize');
});

/**
 * function for attaching sticky feature
 **/

function attachSticky() {
    // Sticky Chat Block
    $('#chat-block').stick_in_parent({
        parent: '#page-contents',
        offset_top: 70
    });

    // Sticky Right Sidebar
    $('#sticky-sidebar').stick_in_parent({
        parent: '#page-contents',
        offset_top: 70
    });

}

// Disable Sticky Feature in Mobile
$(window).on("resize", function () {

    if ($.isFunction($.fn.stick_in_parent)) {
        // Check if Screen wWdth is Less Than or Equal to 992px, Disable Sticky Feature
        if ($(this).width() <= 992) {
            $('#chat-block').trigger('sticky_kit:detach');
            $('#sticky-sidebar').trigger('sticky_kit:detach');

            return;
        } else {

            // Enabling Sticky Feature for Width Greater than 992px
            attachSticky();
        }

        // Firing Sticky Recalculate on Screen Resize
        return function (e) {
            return $(document.body).trigger("sticky_kit:recalc");
        };
    }
});

// Fuction for map initialization
function initMap() {
    var uluru = { lat: 12.927923, lng: 77.627108 };
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 15,
        center: uluru,
        zoomControl: true,
        scaleControl: false,
        scrollwheel: false,
        disableDoubleClickZoom: true
    });

    var marker = new google.maps.Marker({
        position: uluru,
        map: map
    });
}