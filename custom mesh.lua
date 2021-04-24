local BUS = {
  MeshId = "rbxassetid://6281383016";
  TextureId = "rbxassetid://6281384312";
  Offset = Vector3.new(0,0,2);
  Scale = Vector3.new(0.1,0.1,0.1);
  Rotation = -90;
}
workspace.Client.ChildAdded:Connect(function(c)
  local m = c:FindFirstChildOfClass("SpecialMesh")
  if not m then return end
  m.MeshId = BUS.MeshId
  m.TextureId = BUS.TextureId
  m.Offset = BUS.Offset
  m.Scale = BUS.Scale
  c:GetPropertyChangedSignal("CFrame"):Connect(function()
    c.Rotation = Vector3.new(0,BUS.Rotation,0)
  end)
end)