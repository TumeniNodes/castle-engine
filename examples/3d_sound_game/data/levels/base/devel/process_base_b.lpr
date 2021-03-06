{
  Copyright 2003-2017 Michalis Kamburelis.

  This file is part of "lets_take_a_walk".

  "lets_take_a_walk" is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  "lets_take_a_walk" is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with "lets_take_a_walk"; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA

  ----------------------------------------------------------------------------
}

{ Process base_b.wrl adding appropriate items.
  Run this always after generating base_b.wrl from Blender
  (this depends it was generated by ancient Blender 2.4x VRML 1.0 exporter).
}

uses SysUtils, CastleUtils, X3DNodes, CastleVectors, CastleTimeUtils;

const
  BasePath= '../../';
  InVrmlURL = BasePath + 'devel/vrml/base_b.wrl';
  OutVrmlURL = BasePath + 'vrml/base_b_proc.wrl';

var
  RootNode: TX3DNode;

  { te node'y znajdziemy w RootNode }
  MeshBasePlaneNode: TX3DNode;
  Coordinate3ForMeshBasePlane: TCoordinate3Node_1;
  StreetIFS, GroundIFS: TIndexedFaceSetNode_1;

  { te node'y stworzymy i dodamy do MeshBasePlaneNode }
  Texture2ForMeshBasePlane: TTexture2Node_1;
  TextureCoordinate2ForMeshBasePlane: TTextureCoordinate2Node_1;

  i: Integer;
begin
 RootNode := LoadX3DClassic(InVrmlURL, false);
 try
  { find nodes we will need to operate on }
  MeshBasePlaneNode := RootNode.FindNodeByName(TX3DNode, 'MeshBasePlane', false);
  Coordinate3ForMeshBasePlane:=(MeshBasePlaneNode.FindNode
    (TCoordinate3Node_1, false) as TCoordinate3Node_1);
  StreetIFS := (MeshBasePlaneNode.VRML1Children[2] as TIndexedFaceSetNode_1);
  GroundIFS := (MeshBasePlaneNode.VRML1Children[4] as TIndexedFaceSetNode_1);

  { add Texture2ForMeshBasePlane }
  Texture2ForMeshBasePlane := TTexture2Node_1.Create;
  Texture2ForMeshBasePlane.FdFileName.Value := 'textures/base_shadowed.png';
  MeshBasePlaneNode.VRML1ChildAdd(0, Texture2ForMeshBasePlane);

  { add TextureCoordinate2ForMeshBasePlane }
  TextureCoordinate2ForMeshBasePlane := TTextureCoordinate2Node_1.Create;
  TextureCoordinate2ForMeshBasePlane.FdPoint.Items.Count :=
    Coordinate3ForMeshBasePlane.FdPoint.Items.Count;
  for i := 0 to Coordinate3ForMeshBasePlane.FdPoint.Items.Count - 1 do
   TextureCoordinate2ForMeshBasePlane.FdPoint.Items.List^[i] :=
     Vector2Single(
       MapRange(Coordinate3ForMeshBasePlane.FdPoint.Items.List^[i, 0], -4.55, 5.45, 0.0, 1.0),
       MapRange(Coordinate3ForMeshBasePlane.FdPoint.Items.List^[i, 1], -4.57, 4.23, 0.0, 1.0));
  MeshBasePlaneNode.VRML1ChildAdd(1, TextureCoordinate2ForMeshBasePlane);

  { add textureCoordIndex fields to Street and Ground IFS }
  StreetIFS.FdTextureCoordIndex.Items.Assign(StreetIFS.FdCoordIndex.Items);
  GroundIFS.FdTextureCoordIndex.Items.Assign(GroundIFS.FdCoordIndex.Items);

  Save3D(RootNode, OutVrmlURL, 'process_base_b', '', xeClassic);
 finally RootNode.Free end;
end.
