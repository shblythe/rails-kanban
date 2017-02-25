function allowDrop(ev) {
  console.log("allowDrop");
  ev.preventDefault();
}
function drag(ev) {
  console.log("drag",ev.target.id);
  ev.dataTransfer.setData("text",ev.target.id);
}
function drop(ev) {
  console.log("*drop",ev.target.id);
  ev.preventDefault();
  if (ev.target.id.indexOf("Col_")==-1)
    return;
  var data=ev.dataTransfer.getData("text");
  url="tasks/"+data.split("_")[1]+"/change?state="
                      +ev.target.id.split("_")[1].toLowerCase();
  console.log(url);
  var xhttp=new XMLHttpRequest();
  xhttp.onreadystatechange=function() {
    if (this.readyState==4 && this.status==200)
    {
      ev.target.appendChild(document.getElementById(data));
    }
  };
  xhttp.open("POST",url,true);
  xhttp.setRequestHeader("X-CSRF-Token",
                          $('meta[name="csrf-token"]').attr('content'))
  xhttp.send("state=open");
}
