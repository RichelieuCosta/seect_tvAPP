-- require 'util'

barra_lateral =  canvas:new('../../images/common/barra_lateral.png');

topTitulo = {}
topTitulo[1] = '../../images/00MENU_PRINCIPAL/assuntos_n.png' --1
topTitulo[2] = '../../images/00MENU_PRINCIPAL/assuntos_s.png' --1

bottomTitulo = {}
bottomTitulo[1] = '../../images/common/infor_naveg.png' --1
bottomTitulo[2] = '../../images/common/infor_naveg.png' --1

posOK=0

bottomList = {}
bottomList[1] = '../../images/common/op_material_aulas.png'--1
bottomList[2] = '../../images/common/op_apps.png' --2
bottomList[3] = '../../images/common/op_calendar.png' --3


selBottomList = {}
selBottomList[1] = '../../images/common/op_material_aulas.png'--1
selBottomList[2] = '../../images/common/op_apps.png' --2
selBottomList[3] = '../../images/common/op_calendar.png' --3

rectangle_select = canvas:new('../../images/common/op_select.png')
apps = canvas:new('../../images/common/aplicativo_pb_educa.png')

TitleBottomList = {}

selTitleBottomList = {}


setaUp = canvas:new('../../images/common/seta_cima.png');
setaDown = canvas:new('../../images/common/seta_baixo.png');

Button = {}
Button.__index = Button

function Button.create(imgPath, imgSelPath, X, Y, clickable)
  local newButton = {}
  setmetatable(newButton, Button)

    --print("util.lua:52 canvas:new ", imgPath)

  newButton.img = canvas:new(imgPath)
  if imgSelPath then
    --print("util.lua:56 canvas:new ", imgSelPath)
    
    newButton.imgSel = canvas:new(imgSelPath)
  end
  newButton.x = X
  newButton.y = Y
  newButton.canClick = clickable

  return newButton
end

function Button:show()
  local aux
  if (self.imgSel) and (self.canClick) then
    aux = self.imgSel
  else
    aux = self.img
  end

  canvas:compose(self.x, self.y, aux)
end


Menu = {}
Menu.__index = Menu


function Menu.create(images, selImages, text, Seta)
  local newMenu = {}
  setmetatable(newMenu, Menu)
  newMenu.focus = 0
  newMenu.total = 0
  newMenu.index = 0
  newMenu.img = {}
  newMenu.selImg = {}
  newMenu.txt = {}
  newMenu.seta = {}
  newMenu.images = {}
  newMenu.selImages = {}
  newMenu.titulo = {}

  if (images ~= nil) then
    newMenu.total = #images
    newMenu.index = 1
    local i = 1
    for i = 1, #images do
      newMenu.img[i] = nil
      newMenu.images[i] = images[i]
    end
  end

  if (selImages ~= nil) then
    newMenu.total = #selImages
    newMenu.index = 1
    local i = 1
    for i = 1, #selImages do
      newMenu.selImg[i] = nil
      newMenu.selImages[i] = selImages[i]
    end
  end


  if (text ~= nil) then
    newMenu.total = #text
    newMenu.index = 1
    local i = 1
    for i = 1, #text do
      newMenu.txt[i] = text[i]
    end
  end

  if (Seta ~= nil) then
    local i = 1
    for i = 1, #Seta do
     
      newMenu.seta[i] = canvas:new(Seta[i])
    end
  end

  return newMenu
end

function Menu:setTitulo(listTitulo)

  self.titulo=listTitulo

end

function Menu:moveIndex(forward)
  if forward then
  
    if self.index < self.total then
      self.index = self.index + 1
    --  self.index = self.total
    else
      self.index=1
    end
  else
    
    if self.index > 1 then
      self.index = self.index - 1
    else
      self.index=self.total
    end
  end
end



function Menu:release()

    local i = 1
  for i = 1, #self.images do
      self.img[i] = nil
  end
  
  i = 1
  for i = 1, #self.selImages do
      self.selImg[i] = nil
  end
  
  collectgarbage()
  

end

foot = {}

--foot.bar = Button.create('../../images/common/barra_Foot.png', nil, 0, 654, false)
foot.red = Button.create('../../images/common/botao_sair.png', nil, 236, 654, true) -- 567 , 606
foot.green = Button.create('../../images/common/botao_voltar.png', nil, 113, 654, true)
--foot.yellow = Button.create('../../images/common/botao_Fundo_Ouvir.png', nil, 811, 654, true)
--foot.blue = Button.create('../../images/common/botao_Fundo_Ajuda.png', nil, 890, 654, true)
foot.naveg = Button.create('../../images/common/infor_naveg.png', nil, 70, 113, false)



local bottomMenu = Menu.create(bottomList, selBottomList, nil, nil)

bottomMenu:setTitulo(bottomTitulo)
bottomMenu.focus = 1
bottomMenu.firstPos, bottomMenu.numOpcoesVisiveis = 1, 3
bottomMenu.lastPos = bottomMenu.firstPos + bottomMenu.numOpcoesVisiveis

function Menu:show(iniX, iniY, verticalDiff)
  if self.index >= self.total then     --ambiguidade $%%%%
    self.index = self.total
  elseif self.index <= 1 then
    self.index = 1
  end

  if self.index > self.lastPos and self.lastPos < self.total then  --ambiguidade $%%%%
    self.firstPos = self.firstPos + 1
  elseif self.index < self.firstPos then
    self.firstPos = self.firstPos - 1
  end

  if self.index == 1 then
    self.firstPos = 1
  end

  self.lastPos = self.firstPos + self.numOpcoesVisiveis - 1

  if(self.lastPos > self.total) then
    self.lastPos = self.total
  end

  print('first pos '..self.firstPos, 'last pos '..self.lastPos, 'index '..self.index, 'opt visiveis '..self.numOpcoesVisiveis, 'total '..self.total)
  
  
  if self.focus == 1 then
    --tituloShow=canvas:new(self.titulo[2])
    --canvas:compose(iniX  - 0, iniY -90, tituloShow)
    canvas:compose( 58 -27, 317 -11, rectangle_select)
    canvas:compose(iniX + 30, iniY + 84, setaUp)
    canvas:compose(iniX + 30, iniY + 210, setaDown)
  else 
    print('nada 1')  
  end
  
  local box
  local j, x, y = 1, 0, 0
  local iaux=self.index
  for i = self.index, (self.index+self.numOpcoesVisiveis-1) do -- (numOpcoesVisiveis-1) do --- ou (self.lastPos-self.firstPos)
    print((i)%(self.lastPos-self.firstPos+1))
    print('i vale: '..i)
    print('iaux vale: '..iaux)
   
    if iaux == (self.index) then
      if self.focus == 1 then
        box = canvas:new(self.selImages[iaux])

        y = (iniY ) + ((68+0+verticalDiff) * j)
        x = iniX
      --print('teste sem variavel '..box:attrSize()[2])
      print(' to passando por esse if de show')
      else
        print('nada 2')
        
      end
--      boxLargura, boxAltura = box:attrSize()
--      print('Largura: '..boxLargura..' \n Altura: '.. boxAltura)
     
      print('\n teste 2 ')
     
    else
      box = canvas:new(self.images[iaux])
      y = iniY  + ((68+0+verticalDiff) * j)
      x = iniX
      print(' to passando por esse else de show')
    end
      
      j = j + 1
      if ( j > 2) then
        j=0
      end
     -- print(box:attrSize()[2])
    
         
     
    canvas:compose(x, y, box)
   
    
    if(i%(self.lastPos-self.firstPos+1)<1) then
      iaux=1
    else
      iaux=1+iaux
    end

  end

  
end



function drawFoot(red, green, yellow, directions)
    --canvas:compose(foot.bar.x, foot.bar.y, foot.bar.img)
  if red then
    -- canvas:compose(foot.red.x, foot.red.y, foot.red.img)
    canvas:compose(foot.red.x, foot.red.y, foot.red.img)
  end
  if green then
    --canvas:compose(foot.green.x, foot.green.y, foot.green.img)
    canvas:compose(foot.green.x, foot.green.y, foot.green.img)
  end
  if yellow then
    --canvas:compose(foot.yellow.x, foot.yellow.y, foot.yellow.img)
    canvas:compose(853, 606, foot.yellow.img)
  end
  if directions then
    canvas:compose(foot.naveg.x, foot.naveg.y, foot.naveg.img)
  end
  
end


function showScreen(op_show)
  canvas:attrColor(0, 0, 0, 0)
  canvas:clear()
  canvas:attrColor(0, 0, 0, 255)
  
  if (op_show == 0) then

      canvas:compose(0, 0, barra_lateral)
      drawFoot(true, false, false, true) -- true pra mostrar (red, green, yellow, directions)    
     
      bottomMenu:show(70, 203, 58)
  
  elseif(op_show == 1) then 

      canvas:compose(0, 0, barra_lateral)
      drawFoot(true, true, false, false) -- true pra mostrar (red, green, yellow, directions)    
      --canvas:compose(42 - 16, 113, apps)
     

  elseif(op_show == 2) then 

      canvas:compose(0, 0, barra_lateral)
      drawFoot(true, true, false, false) -- true pra mostrar (red, green, yellow, directions)    
      canvas:compose(42 -29, 113, apps)
     

  elseif(op_show == 3) then 

      canvas:compose(0, 0, barra_lateral)
      drawFoot(true, true, false, false) -- true pra mostrar (red, green, yellow, directions)    
      --canvas:compose(42, 113, apps)
     

  end

  

  canvas:flush()

end



COUNT = 0
function handler(evt)
  print("Menu Principal Evento disparado: " .. evt.class .. " " .. evt.type)
  print('posOK: '..posOK)
  COUNT= COUNT +1
  if (evt.class == 'ncl' and evt.type == 'presentation' and evt.action=='start') then-- 'ncl', 'presentation', 'start' )
 
    showScreen(0)
    return
  elseif (evt.class == 'key' and evt.type == 'press') then
    print(evt.key)
    if evt.key == "ENTER" then
      
      local option;
          if(bottomMenu.index==1)then
            posOK=1
            showScreen(1)
          end
          if(bottomMenu.index==2)then
            posOK=2
            showScreen(2)
          end
          if(bottomMenu.index==3)then
            posOK=3
            showScreen(3)
          end
      -- if topMenu.focus == 1 then
      --   option = 'op'..topMenu.index;
      -- else
        option = 'op'..(bottomMenu.index + bottomMenu.total);
      -- end

      print(option)
      -- event.post {
      --   class    = 'ncl',
      --   type     = 'presentation',
      --   label = option,
      --   action   = 'start',
      -- }
      -- event.post {
      --   class    = 'ncl',
      --   type     = 'presentation',
      --   label = option,
      --   action   = 'stop',
      -- }
      -- return
   

    elseif evt.key == "CURSOR_UP" and posOK == 0  then
        print('oooooooooou rapaz')
      if bottomMenu.focus == 1 then
       
        bottomMenu:moveIndex(false)
        showScreen(0)
      end

    elseif evt.key == "CURSOR_DOWN" and posOK == 0 then

      if bottomMenu.focus == 1 then
       
        bottomMenu:moveIndex(true)
        showScreen(0)
      end

    elseif evt.key == "GREEN" then
      print('apertou o botão green')
      if (posOK~=0) then
        posOK=0
        showScreen(posOK)
      end
      -- event.post {
      --   class    = 'ncl',
      --   type     = 'presentation',
      --   label = 'green_mainP',
      --   action   = 'start',
      -- }
      -- event.post {
      --   class    = 'ncl',
      --   type     = 'presentation',
      --   label = 'op1',
      --   action   = 'stop',
      -- }
      return
    elseif (evt.key == "RED") then

      event.post {
        class    = 'ncl',
        type     = 'presentation',
        label = 'op1',
        action   = 'start',
      }
      event.post {
        class    = 'ncl',
        type     = 'presentation',
        label = 'op1',
        action   = 'stop',
      }
      return

    end
    
    return
  end
  print('chegou aqui'..COUNT)

end




event.register(handler)
