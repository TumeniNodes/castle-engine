{ -*- buffer-read-only: t -*-

  Copyright 2015-2017 Michalis Kamburelis.

  This file is part of "Castle Game Engine".

  "Castle Game Engine" is free software; see the file COPYING.txt,
  included in this distribution, for details about the copyright.

  "Castle Game Engine" is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

  ----------------------------------------------------------------------------
}

{ Automatically generated node properties.

  Do not edit this file manually!
  To add new properties, add them to text files in nodes_specification/components/ ,
  and regenerate include files by running
  nodes_specification/generate_x3d_nodes_to_pascal.lpr .

  The documentation for properties should go to x3dnodes_documentation.txt . }

{$ifdef read_interface}

  private
    function GetTimeOut: TFloatTime;
    procedure SetTimeOut(const Value: TFloatTime);
  public
    property TimeOut: TFloatTime read GetTimeOut write SetTimeOut;

{$endif read_interface}

{$ifdef read_implementation}

{ TLoadSensorNode ----------------------------------------------- }

function TLoadSensorNode.GetTimeOut: TFloatTime;
begin
  Result := FdTimeOut.Value;
end;

procedure TLoadSensorNode.SetTimeOut(const Value: TFloatTime);
begin
  FdTimeOut.Send(Value);
end;

{$endif read_implementation}
