pacman rest example
===================

formato == json / xml

GET /listarUmCaminho/de/para.formato


  $ curl -s http://pacman-rest.herokuapp.com/listarUmCaminho/49/285.xml
  
  {
     "caminho" : [
        "49",
        "87",
        "279",
        "285"
     ]
  }


GET /listarMenorCaminho/de/para.formato

  $ curl -s http://pacman-rest.herokuapp.com/listarMenorCaminho/49/285.xml
  
  {
   "caminho" : [
      "49",
      "87",
      "285"
   ]
  }


GET /calcularTempoMenorCaminho/de/para.formato

  $ curl -s http://pacman-rest.herokuapp.com/calcularTempoMenorCaminho/49/285.xml
  
  {
   "de" : "49",
   "tempo" : 18,
   "para" : "285"
  }
