function allowDrop(ev) {
  console.log("allowDrop");
  ev.preventDefault();
}
function drag(ev) {
  console.log("drag",ev.target.id);
  ev.dataTransfer.setData("text",ev.target.id);
}
function drop(ev) {
  console.log("drop",ev.target.id);
  ev.preventDefault();
  var data=ev.dataTransfer.getData("text");
  ev.target.appendChild(document.getElementById(data));
}
