{
  Copyright 2010-2010 Michalis Kamburelis.

  This file is part of "Kambi VRML game engine".

  "Kambi VRML game engine" is free software; see the file COPYING.txt,
  included in this distribution, for details about the copyright.

  "Kambi VRML game engine" is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

  ----------------------------------------------------------------------------
}

{ Simplest demo of using TKamSceneManager.

  For even simpler usage, you can see at simplest_vrml_browser.lpr.
  Program below explicitly creates SceneManager and Scene instances,
  to make more clear what's going on. }
program scene_manager_basic;

uses GLWindow, VRMLScene, VRMLGLScene, KambiSceneManager;

var
  Window: TGLUIWindow;
  SceneManager: TKamSceneManager;
  Scene: TVRMLGLScene;
begin
  Scene := TVRMLGLScene.Create(Application { Owner that will free the Scene });
  Scene.Load('models/boxes.x3dv');
  Scene.Spatial := [ssRendering, ssDynamicCollisions];
  Scene.ProcessEvents := true;

  SceneManager := TKamSceneManager.Create(Application);
  SceneManager.Items.Add(Scene);
  SceneManager.MainScene := Scene;

  Window := TGLUIWindow.Create(Application);
  Window.Controls.Add(SceneManager);
  Window.InitAndRun;
end.
