pacman rest example
===================

formato == json / xml

GET /listarUmCaminho/de/para.formato


  $ curl -s http://pacman-rest.herokuapp.com/listarUmCaminho/49/285.xml
  <data>
    <caminho>49</caminho>
    <caminho>87</caminho>
    <caminho>279</caminho>
    <caminho>285</caminho>
  </data>

GET /listarMenorCaminho/de/para.formato

  $ curl -s http://pacman-rest.herokuapp.com/listarMenorCaminho/49/285.xml
  <data>
    <caminho>49</caminho>
    <caminho>87</caminho>
    <caminho>285</caminho>
  </data>

GET /calcularTempoMenorCaminho/de/para.formato

  $ curl -s http://pacman-rest.herokuapp.com/calcularTempoMenorCaminho/49/285.xml
  <data de="49" para="285" tempo="18" />
