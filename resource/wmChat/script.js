var isOpaque = false

function makeAllOpaque(){
    var body = document.getElementsByTagName("BODY")[0];

    body.className = "showScrollbar"

    var allChatDivs = document.getElementsByName("chatObject");
    isOpaque = true;

    for(var i=0; i < allChatDivs.length; i++){
        allChatDivs[i].className = "visible";
    }
}

function makeNormal(){
    var body = document.getElementsByTagName("BODY")[0];

    body.className = "hideScrollbar"

    var allChatDivs = document.getElementsByName("chatObject");
    isOpaque = false;

    for(var i=0; i < allChatDivs.length; i++){
        if (allChatDivs[i].getAttribute("data-faded") == 1){
            allChatDivs[i].className = "hidden";
        }
    }
}

function makeFade(elementId, time){
    setTimeout(function(){
        var textToFade = document.getElementById(elementId);
        textToFade.setAttribute("data-faded", 1);

        if (isOpaque === false){
            textToFade.className = "hidden";
        };
    }, time*1000)
}

function clearSelection() {
 if (window.getSelection) {window.getSelection().removeAllRanges();}
 else if (document.selection) {document.selection.empty();}
}