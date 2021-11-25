const SAMPLE_STUDENT_DATA = '''[{
  "coderName": "bedworthie0",
  "profilePictureURL": "http://tinyurl.com/dis/parturient/montes/nascetur.html?nec=congue&condimentum=vivamus&neque=metus&sapien=arcu&placerat=adipiscing&ante=molestie&nulla=hendrerit&justo=at&aliquam=vulputate&quis=vitae&turpis=nisl&eget=aenean&elit=lectus&sodales=pellentesque&scelerisque=eget&mauris=nunc&sit=donec&amet=quis&eros=orci&suspendisse=eget&accumsan=orci&tortor=vehicula&quis=condimentum&turpis=curabitur&sed=in&ante=libero&vivamus=ut&tortor=massa&duis=volutpat&mattis=convallis&egestas=morbi&metus=odio&aenean=odio&fermentum=elementum&donec=eu&ut=interdum&mauris=eu&eget=tincidunt&massa=in&tempor=leo&convallis=maecenas&nulla=pulvinar&neque=lobortis&libero=est&convallis=phasellus&eget=sit&eleifend=amet&luctus=erat&ultricies=nulla&eu=tempus&nibh=vivamus&quisque=in&id=felis&justo=eu&sit=sapien&amet=cursus&sapien=vestibulum&dignissim=proin&vestibulum=eu&vestibulum=mi&ante=nulla&ipsum=ac&primis=enim&in=in&faucibus=tempor&orci=turpis&luctus=nec&et=euismod&ultrices=scelerisque&posuere=quam&cubilia=turpis&curae=adipiscing&nulla=lorem&dapibus=vitae&dolor=mattis&vel=nibh&est=ligula&donec=nec&odio=sem",
  "listOfProjects": [{
  "title": "Rank",
  "videoURL": "http://twitter.com/amet.jpg?ac=morbi&leo=odio&pellentesque=odio&ultrices=elementum&mattis=eu&odio=interdum",
  "language": "Montenegrin",
  "description": "nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra"
}, {
  "title": "Konklux",
  "videoURL": "https://goo.ne.jp/consectetuer.aspx?faucibus=turpis&orci=sed&luctus=ante&et=vivamus&ultrices=tortor&posuere=duis&cubilia=mattis&curae=egestas&mauris=metus&viverra=aenean&diam=fermentum&vitae=donec&quam=ut&suspendisse=mauris&potenti=eget&nullam=massa&porttitor=tempor&lacus=convallis&at=nulla&turpis=neque&donec=libero&posuere=convallis&metus=eget&vitae=eleifend&ipsum=luctus&aliquam=ultricies&non=eu&mauris=nibh&morbi=quisque&non=id&lectus=justo&aliquam=sit&sit=amet&amet=sapien&diam=dignissim&in=vestibulum&magna=vestibulum&bibendum=ante&imperdiet=ipsum&nullam=primis&orci=in&pede=faucibus&venenatis=orci&non=luctus&sodales=et&sed=ultrices&tincidunt=posuere&eu=cubilia&felis=curae&fusce=nulla&posuere=dapibus&felis=dolor&sed=vel&lacus=est&morbi=donec&sem=odio&mauris=justo&laoreet=sollicitudin&ut=ut&rhoncus=suscipit",
  "language": "Finnish",
  "description": "platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at"
}, {
  "title": "Alphazap",
  "videoURL": "https://angelfire.com/neque/libero.xml?dui=nonummy&proin=maecenas&leo=tincidunt&odio=lacus&porttitor=at&id=velit&consequat=vivamus&in=vel&consequat=nulla&ut=eget&nulla=eros&sed=elementum&accumsan=pellentesque&felis=quisque&ut=porta&at=volutpat&dolor=erat&quis=quisque&odio=erat&consequat=eros&varius=viverra&integer=eget&ac=congue&leo=eget&pellentesque=semper&ultrices=rutrum&mattis=nulla&odio=nunc&donec=purus&vitae=phasellus&nisi=in",
  "language": "Danish",
  "description": "pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu"
}],
  "codeCoach": "Berenice",
  "thumbnailURL": "http://dummyimage.com/218x100.png/5fa2dd/ffffff"
}, {
  "coderName": "wpeasey1",
  "profilePictureURL": "https://sina.com.cn/varius/nulla/facilisi/cras/non/velit/nec.png?eget=eu&tempus=mi",
  "listOfProjects":[{
  "title": "Rank",
  "videoURL": "http://twitter.com/amet.jpg?ac=morbi&leo=odio&pellentesque=odio&ultrices=elementum&mattis=eu&odio=interdum",
  "language": "Montenegrin",
  "description": "nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra"
}, {
  "title": "Konklux",
  "videoURL": "https://goo.ne.jp/consectetuer.aspx?faucibus=turpis&orci=sed&luctus=ante&et=vivamus&ultrices=tortor&posuere=duis&cubilia=mattis&curae=egestas&mauris=metus&viverra=aenean&diam=fermentum&vitae=donec&quam=ut&suspendisse=mauris&potenti=eget&nullam=massa&porttitor=tempor&lacus=convallis&at=nulla&turpis=neque&donec=libero&posuere=convallis&metus=eget&vitae=eleifend&ipsum=luctus&aliquam=ultricies&non=eu&mauris=nibh&morbi=quisque&non=id&lectus=justo&aliquam=sit&sit=amet&amet=sapien&diam=dignissim&in=vestibulum&magna=vestibulum&bibendum=ante&imperdiet=ipsum&nullam=primis&orci=in&pede=faucibus&venenatis=orci&non=luctus&sodales=et&sed=ultrices&tincidunt=posuere&eu=cubilia&felis=curae&fusce=nulla&posuere=dapibus&felis=dolor&sed=vel&lacus=est&morbi=donec&sem=odio&mauris=justo&laoreet=sollicitudin&ut=ut&rhoncus=suscipit",
  "language": "Finnish",
  "description": "platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at"
}, {
  "title": "Alphazap",
  "videoURL": "https://angelfire.com/neque/libero.xml?dui=nonummy&proin=maecenas&leo=tincidunt&odio=lacus&porttitor=at&id=velit&consequat=vivamus&in=vel&consequat=nulla&ut=eget&nulla=eros&sed=elementum&accumsan=pellentesque&felis=quisque&ut=porta&at=volutpat&dolor=erat&quis=quisque&odio=erat&consequat=eros&varius=viverra&integer=eget&ac=congue&leo=eget&pellentesque=semper&ultrices=rutrum&mattis=nulla&odio=nunc&donec=purus&vitae=phasellus&nisi=in",
  "language": "Danish",
  "description": "pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu"
}],
  "codeCoach": "Wandis",
  "thumbnailURL": "http://dummyimage.com/128x100.png/cc0000/ffffff"
}, {
  "coderName": "ecaldero2",
  "profilePictureURL": "https://nationalgeographic.com/nunc/viverra/dapibus/nulla/suscipit.aspx?varius=sapien&ut=urna&blandit=pretium&non=nisl&interdum=ut&in=volutpat&ante=sapien&vestibulum=arcu&ante=sed&ipsum=augue&primis=aliquam&in=erat&faucibus=volutpat&orci=in&luctus=congue&et=etiam",
  "listOfProjects": [{
  "title": "Rank",
  "videoURL": "http://twitter.com/amet.jpg?ac=morbi&leo=odio&pellentesque=odio&ultrices=elementum&mattis=eu&odio=interdum",
  "language": "Montenegrin",
  "description": "nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra"
}, {
  "title": "Konklux",
  "videoURL": "https://goo.ne.jp/consectetuer.aspx?faucibus=turpis&orci=sed&luctus=ante&et=vivamus&ultrices=tortor&posuere=duis&cubilia=mattis&curae=egestas&mauris=metus&viverra=aenean&diam=fermentum&vitae=donec&quam=ut&suspendisse=mauris&potenti=eget&nullam=massa&porttitor=tempor&lacus=convallis&at=nulla&turpis=neque&donec=libero&posuere=convallis&metus=eget&vitae=eleifend&ipsum=luctus&aliquam=ultricies&non=eu&mauris=nibh&morbi=quisque&non=id&lectus=justo&aliquam=sit&sit=amet&amet=sapien&diam=dignissim&in=vestibulum&magna=vestibulum&bibendum=ante&imperdiet=ipsum&nullam=primis&orci=in&pede=faucibus&venenatis=orci&non=luctus&sodales=et&sed=ultrices&tincidunt=posuere&eu=cubilia&felis=curae&fusce=nulla&posuere=dapibus&felis=dolor&sed=vel&lacus=est&morbi=donec&sem=odio&mauris=justo&laoreet=sollicitudin&ut=ut&rhoncus=suscipit",
  "language": "Finnish",
  "description": "platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at"
}, {
  "title": "Alphazap",
  "videoURL": "https://angelfire.com/neque/libero.xml?dui=nonummy&proin=maecenas&leo=tincidunt&odio=lacus&porttitor=at&id=velit&consequat=vivamus&in=vel&consequat=nulla&ut=eget&nulla=eros&sed=elementum&accumsan=pellentesque&felis=quisque&ut=porta&at=volutpat&dolor=erat&quis=quisque&odio=erat&consequat=eros&varius=viverra&integer=eget&ac=congue&leo=eget&pellentesque=semper&ultrices=rutrum&mattis=nulla&odio=nunc&donec=purus&vitae=phasellus&nisi=in",
  "language": "Danish",
  "description": "pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu"
}],
  "codeCoach": "Eloise",
  "thumbnailURL": "http://dummyimage.com/119x100.png/dddddd/000000"
}, {
  "coderName": "meicheler3",
  "profilePictureURL": "https://tamu.edu/suspendisse/ornare/consequat/lectus/in/est.html?ipsum=ridiculus&primis=mus&in=vivamus&faucibus=vestibulum&orci=sagittis&luctus=sapien&et=cum&ultrices=sociis&posuere=natoque&cubilia=penatibus&curae=et&duis=magnis&faucibus=dis&accumsan=parturient&odio=montes&curabitur=nascetur&convallis=ridiculus&duis=mus&consequat=etiam&dui=vel&nec=augue&nisi=vestibulum&volutpat=rutrum&eleifend=rutrum&donec=neque&ut=aenean&dolor=auctor&morbi=gravida&vel=sem&lectus=praesent&in=id&quam=massa&fringilla=id&rhoncus=nisl&mauris=venenatis&enim=lacinia&leo=aenean&rhoncus=sit&sed=amet&vestibulum=justo&sit=morbi&amet=ut&cursus=odio&id=cras&turpis=mi&integer=pede&aliquet=malesuada&massa=in&id=imperdiet&lobortis=et&convallis=commodo",
  "listOfProjects": [{
  "title": "Rank",
  "videoURL": "http://twitter.com/amet.jpg?ac=morbi&leo=odio&pellentesque=odio&ultrices=elementum&mattis=eu&odio=interdum",
  "language": "Montenegrin",
  "description": "nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra"
}, {
  "title": "Konklux",
  "videoURL": "https://goo.ne.jp/consectetuer.aspx?faucibus=turpis&orci=sed&luctus=ante&et=vivamus&ultrices=tortor&posuere=duis&cubilia=mattis&curae=egestas&mauris=metus&viverra=aenean&diam=fermentum&vitae=donec&quam=ut&suspendisse=mauris&potenti=eget&nullam=massa&porttitor=tempor&lacus=convallis&at=nulla&turpis=neque&donec=libero&posuere=convallis&metus=eget&vitae=eleifend&ipsum=luctus&aliquam=ultricies&non=eu&mauris=nibh&morbi=quisque&non=id&lectus=justo&aliquam=sit&sit=amet&amet=sapien&diam=dignissim&in=vestibulum&magna=vestibulum&bibendum=ante&imperdiet=ipsum&nullam=primis&orci=in&pede=faucibus&venenatis=orci&non=luctus&sodales=et&sed=ultrices&tincidunt=posuere&eu=cubilia&felis=curae&fusce=nulla&posuere=dapibus&felis=dolor&sed=vel&lacus=est&morbi=donec&sem=odio&mauris=justo&laoreet=sollicitudin&ut=ut&rhoncus=suscipit",
  "language": "Finnish",
  "description": "platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at"
}, {
  "title": "Alphazap",
  "videoURL": "https://angelfire.com/neque/libero.xml?dui=nonummy&proin=maecenas&leo=tincidunt&odio=lacus&porttitor=at&id=velit&consequat=vivamus&in=vel&consequat=nulla&ut=eget&nulla=eros&sed=elementum&accumsan=pellentesque&felis=quisque&ut=porta&at=volutpat&dolor=erat&quis=quisque&odio=erat&consequat=eros&varius=viverra&integer=eget&ac=congue&leo=eget&pellentesque=semper&ultrices=rutrum&mattis=nulla&odio=nunc&donec=purus&vitae=phasellus&nisi=in",
  "language": "Danish",
  "description": "pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu"
}],
  "codeCoach": "Michele",
  "thumbnailURL": "http://dummyimage.com/207x100.png/dddddd/000000"
}, {
  "coderName": "fmoverley4",
  "profilePictureURL": "https://miitbeian.gov.cn/at/nulla/suspendisse/potenti/cras.xml?vulputate=nulla&luctus=sed&cum=accumsan&sociis=felis&natoque=ut&penatibus=at&et=dolor&magnis=quis&dis=odio&parturient=consequat&montes=varius&nascetur=integer&ridiculus=ac&mus=leo&vivamus=pellentesque&vestibulum=ultrices&sagittis=mattis&sapien=odio&cum=donec&sociis=vitae&natoque=nisi&penatibus=nam&et=ultrices&magnis=libero&dis=non&parturient=mattis&montes=pulvinar&nascetur=nulla&ridiculus=pede&mus=ullamcorper&etiam=augue&vel=a&augue=suscipit&vestibulum=nulla&rutrum=elit&rutrum=ac&neque=nulla&aenean=sed&auctor=vel&gravida=enim&sem=sit&praesent=amet&id=nunc&massa=viverra",
  "listOfProjects": [{
  "title": "Rank",
  "videoURL": "http://twitter.com/amet.jpg?ac=morbi&leo=odio&pellentesque=odio&ultrices=elementum&mattis=eu&odio=interdum",
  "language": "Montenegrin",
  "description": "nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra"
}, {
  "title": "Konklux",
  "videoURL": "https://goo.ne.jp/consectetuer.aspx?faucibus=turpis&orci=sed&luctus=ante&et=vivamus&ultrices=tortor&posuere=duis&cubilia=mattis&curae=egestas&mauris=metus&viverra=aenean&diam=fermentum&vitae=donec&quam=ut&suspendisse=mauris&potenti=eget&nullam=massa&porttitor=tempor&lacus=convallis&at=nulla&turpis=neque&donec=libero&posuere=convallis&metus=eget&vitae=eleifend&ipsum=luctus&aliquam=ultricies&non=eu&mauris=nibh&morbi=quisque&non=id&lectus=justo&aliquam=sit&sit=amet&amet=sapien&diam=dignissim&in=vestibulum&magna=vestibulum&bibendum=ante&imperdiet=ipsum&nullam=primis&orci=in&pede=faucibus&venenatis=orci&non=luctus&sodales=et&sed=ultrices&tincidunt=posuere&eu=cubilia&felis=curae&fusce=nulla&posuere=dapibus&felis=dolor&sed=vel&lacus=est&morbi=donec&sem=odio&mauris=justo&laoreet=sollicitudin&ut=ut&rhoncus=suscipit",
  "language": "Finnish",
  "description": "platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at"
}, {
  "title": "Alphazap",
  "videoURL": "https://angelfire.com/neque/libero.xml?dui=nonummy&proin=maecenas&leo=tincidunt&odio=lacus&porttitor=at&id=velit&consequat=vivamus&in=vel&consequat=nulla&ut=eget&nulla=eros&sed=elementum&accumsan=pellentesque&felis=quisque&ut=porta&at=volutpat&dolor=erat&quis=quisque&odio=erat&consequat=eros&varius=viverra&integer=eget&ac=congue&leo=eget&pellentesque=semper&ultrices=rutrum&mattis=nulla&odio=nunc&donec=purus&vitae=phasellus&nisi=in",
  "language": "Danish",
  "description": "pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu"
}],
  "codeCoach": "Franklin",
  "thumbnailURL": "http://dummyimage.com/101x100.png/dddddd/000000"
}]''';
const SAMPLE_USER_DATA = '''{
  "role": 4,
  "coderName": "freicherz0"
}''';
