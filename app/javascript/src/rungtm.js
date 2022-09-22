export function runGTM(){
  document.addEventListener("turbo:load", function(event) {
    let url = event.detail.url;

    dataLayer.push({
      'event':'pageView',
      'virtualUrl': url
    });


  });
    (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
    new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
    j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
    'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer','GTM-MM2D5QB');
};
