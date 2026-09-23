-- ColorScript: resaltar botón al pasar el mouse — Módulo 4, Lección 1
--
-- Ubicación: LocalScript dentro de un ImageButton (script.Parent).
--
-- CÓMO USARLO:
-- 1. Selecciona el ImageButton (por ejemplo "SpawnCar" o "DeleteCar")
--    e inserta este script.
-- 2. Presiona Play y pasa el mouse sobre el botón.
--
-- Qué hace: al pasar el mouse por encima, el botón se ve más opaco y
-- ligeramente gris; al salir, vuelve a su transparencia normal.

script.Parent.MouseEnter:Connect(function()
	script.Parent.ImageTransparency = 0
	script.Parent.ImageColor3 = Color3.fromRGB(200, 200, 200)
end)

script.Parent.MouseLeave:Connect(function()
	script.Parent.ImageTransparency = 0.5
	script.Parent.ImageColor3 = Color3.fromRGB(255, 255, 255)
end)
