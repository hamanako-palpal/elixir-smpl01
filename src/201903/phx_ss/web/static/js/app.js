// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
const elmDiv = document.querySelector("#elm-container")
var el = document.getElementById("elm-container")
var lists = elmDiv.getAttribute("items").split('o')
console.log( lists)
lists.forEach(function( value ) {
    console.log( value );
});


const elmApp = Elm.Main.init
    ({flags: {items: elmDiv.items}
    , node: elmDiv})
//const elmApp = Elm.Main.embed(elmDiv)