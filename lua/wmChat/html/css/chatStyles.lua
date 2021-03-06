:root {    
    --colorFrom: white;
    --colorTo: black;
}

body {
    border-color: #AAAAAA;
    border-width: 5px;

    overflow: hidden;
}

body.showScrollbar {
    overflow: auto;
    overflow-x: hidden;
}

body.hideScrollbar {
    overflow: hidden;
}

::-webkit-scrollbar {
  width: 10px;
}

::-webkit-scrollbar-track {
  background: #f1f1f1;
}

::-webkit-scrollbar-thumb {
  background: #888;
}

/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
  background: #555;
}


div.visible{
    opacity: 1;
    transition: opacity 250ms linear;
    -webkit-transition: opacity 250ms linear;
}

div.hidden{
    opacity: 0;
    transition: opacity 250ms linear;
    -webkit-transition: opacity 250ms linear;

    animation: none;
    -webkit-animation: none;
}

div {
    word-wrap: break-word;

	color: white;

	opacity: 1;
	animation: flickerAnimation 1s infinite;
    -webkit-animation: flickerAnimation 1s infinite;
}

@keyframes flickerAnimation{ /* This is used to prevent a black outline on the text itself, due to the html version that gmod uses  */
    0% {opacity:0.99;}
    50%{opacity:1;}
    100%{opacity:0.99}
}

@-webkit-keyframes flickerAnimation{
    0% {opacity:0.99;}
    50%{opacity:1;}
    100%{opacity:0.99}
}

::selection {
    background-color: orange;
}




@keyframes rainbow{
		100%,0%{
			color: rgb(255,0,0);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(255, 0, 0));
		}
		8%{
			color: rgb(255,127,0);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(255, 127, 0));
		}
		16%{
			color: rgb(255,255,0);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(255, 255, 0));
		}
		25%{
			color: rgb(127,255,0);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(127, 255, 0));
		}
		33%{
			color: rgb(0,255,0);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(0, 255, 0));
		}
		41%{
			color: rgb(0,255,127);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(0, 255, 127));
		}
		50%{
			color: rgb(0,255,255);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(0, 255, 255));
		}
		58%{
			color: rgb(0,127,255);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(0, 127, 255));
		}
		66%{
			color: rgb(0,0,255);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(0, 0, 255));
		}
		75%{
			color: rgb(127,0,255);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(127, 0, 255));
		}
		83%{
			color: rgb(255,0,255);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(255, 0, 255));
		}
		91%{
			color: rgb(255,0,127);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(255, 0, 127));
		}
}

@-webkit-keyframes rainbow{
		100%,0%{
			color: rgb(255,0,0);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(255, 0, 0));
		}
		8%{
			color: rgb(255,127,0);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(255, 127, 0));
		}
		16%{
			color: rgb(255,255,0);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(255, 255, 0));
		}
		25%{
			color: rgb(127,255,0);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(127, 255, 0));
		}
		33%{
			color: rgb(0,255,0);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(0, 255, 0));
		}
		41%{
			color: rgb(0,255,127);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(0, 255, 127));
		}
		50%{
			color: rgb(0,255,255);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(0, 255, 255));
		}
		58%{
			color: rgb(0,127,255);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(0, 127, 255));
		}
		66%{
			color: rgb(0,0,255);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(0, 0, 255));
		}
		75%{
			color: rgb(127,0,255);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(127, 0, 255));
		}
		83%{
			color: rgb(255,0,255);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(255, 0, 255));
		}
		91%{
			color: rgb(255,0,127);
			-webkit-filter: drop-shadow(0px 0px 10px rgb(255, 0, 127));
		}
}