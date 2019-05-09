boolean textCheck(String a) {
  boolean yorn;
  //if you can not find them, return true.
  if(a.indexOf("Portal") != -1) {
    yorn = false;
  }else if(a.indexOf("Help") != -1) {
    yorn = false;
  }else {
    yorn = true;
  }
  return yorn;
}
