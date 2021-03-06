<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- Generated by NCL Eclipse -->
<ncl id="testes" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
    <region id="bgreg" height="720" width="1280" top="0" left="0" zIndex="0"/>
			<region id="reg_mainz1" width="1280" height="720" zIndex="1"/>
      <region id="reg_barra_superior" width="1280" height="184" zIndex="2"/>
      <region id="reg_barra_lateral_ncl" width="485" height="720" zIndex="2"/>
      
		</regionBase>
		<descriptorBase>
			<descriptor id="desc_lua" region="reg_mainz1" focusBorderWidth="0"/>
			<descriptor id="desc_imgs_z1" region="reg_mainz1"  focusBorderWidth="0"/>
      <descriptor id="desc_imgs_z2" region="reg_barra_superior" focusBorderWidth="0"/>
      <descriptor id="desc_imgs_z2_barra_lateral" region="reg_barra_lateral_ncl" focusBorderWidth="0" focusIndex="2" />
			<descriptor id="descAudio" focusBorderWidth="0"/>
      <descriptor id="descVideo" region="bgreg" focusIndex="1" focusBorderWidth="0"/>
		</descriptorBase>
		<connectorBase>
			<importBase documentURI="../ConnectorBase.ncl" alias="conn"/>
		</connectorBase>
	</head>
	<body>
		

		<port id="porta_1" component="bg"/>
		<!-- <port id="porta2" component="barra_superior"/> -->
    
    
	
    <!-- <media id="bg" src="../../videos/TV_Paraiba_Educa_entrando_no_ar_oficialmente_1080p.mp4" type="video/mp4" descriptor="descVideo"/> -->
    <media id="bg" src="../../videos/TV_Paraiba_Educa_1080p.mp4" type="video/mp4" descriptor="descVideo"/>
    <media id="bg2" src="../../videos/TV_Paraiba_Educa_1080p.mp4" type="video/mp4" descriptor="descVideo"/>
		<!-- <media id="bg" src="../../images/common/bg_temporario.jpg" type="image/jpg" descriptor="desc_imgs_z1"/> -->

    <media id="barra_superior" src="../../images/common/barra_superior.png" type="image/png" descriptor="desc_imgs_z2"/>
    <media id="barra_lateral_ncl" src="../../images/common/barra_lateral.png" type="image/png" descriptor="desc_imgs_z2_barra_lateral"/>


	  <link id="loop_Video" xconnector="conn#onEndStart">
			<bind role="onEnd" component="bg"/>
			<bind role="start" component="bg2"/>
		</link>

  	<link id="loop_Video" xconnector="conn#onEndStart">
			<bind role="onEnd" component="bg2"/>
			<bind role="start" component="bg2"/>
		</link>

    <media id="Settings" type="application/x-ginga-settings">
      <property name="service.currentFocus" value=""/>
      <property name="service.currentKeyMaster" value="lua_barra_lateral"/>
			<property name="channel.keyCapture" value="numeric_keys,interactive_keys"/>
    </media>

    <media id="lua_barra_lateral" type="application/x-ginga-NCLua" src="../lua/barra_lateral.lua" descriptor="desc_imgs_z2_barra_lateral">
				<area id="op1"/>
				<area id="op2"/>
				<area id="op3"/>
				<area id="op4"/>
				<area id="op5"/>
				<area id="op6"/>
				<area id="op7"/>
				<area id="op8"/>
				<area id="mainYellow"/>
				<area id="red"/>
			</media>

      <link id="startFilme" xconnector="conn#onBeginStartDelayed">
				<bind role="onBegin" component="bg"/>
				<bind role="start" component="barra_superior">
        	<bindParam name="delay" value="3s"/>
        </bind>
			</link>
      
      <link id="loop1_barra_superior" xconnector="conn#onBeginStopDelayed">
				<bind role="onBegin" component="barra_superior"/>
				<bind role="stop" component="barra_superior">
        	<bindParam name="delay" value="5s"/>
        </bind>
			</link>

      <link id="loop2_barra_superior" xconnector="conn#onEndStartDelayed">
				<bind role="onEnd" component="barra_superior"/>
				<bind role="start" component="barra_superior">
        	<bindParam name="delay" value="10s"/>
        </bind>
			</link>

       <link id="loop3_barra_superior" xconnector="conn#onEndStartDelayed">
				<bind role="onEnd" component="lua_barra_lateral"/>
				<bind role="start" component="barra_superior">
        	<bindParam name="delay" value="50s"/>
        </bind>
			</link>

      <link id="de_barra_superior_para_barra_lateral" xconnector="conn#onKeySelectionAbortStart">
          <bind role="onSelection" component="barra_superior">
            <bindParam name="keyCode" value="ENTER"/>
          </bind>
          <bind role="abort" component="barra_superior"/>
          <bind role="start" component="lua_barra_lateral"/>
        
        </link>

      <link id="iniciando_lua_barra_lateral" xconnector="conn#onBeginSetN">
          <bind role="onBegin" component="lua_barra_lateral"/>
          <bind role="set" component="Settings" interface="service.currentKeyMaster">
				      <bindParam name="value" value="lua_barra_lateral"/>
				  </bind>
          <bind role="set" component="Settings" interface="service.currentFocus">
					    <bindParam name="value" value="2"/>
          </bind>
      </link>

      <link id="exitApp" xconnector="conn#onEndStop">
				<bind role="onEnd" component="lua_barra_lateral" interface="op1"/>
				<bind role="stop" component="lua_barra_lateral"/>
			</link>

    
		
	</body>
</ncl>