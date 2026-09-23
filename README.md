# Timeclub Academy — Plugin de Roblox Studio (v1.1.0)

Plugin de Roblox Studio para el curso de diseño de videojuegos. Muestra un catálogo de scripts organizados por lección y los inserta en el lugar correcto del proyecto del alumno con un clic.

## Cómo funciona

- El **catálogo** (`manifest.json`) y el **código fuente de cada script** (carpeta `scripts/`) viven en este repositorio, no dentro del archivo del plugin.
- El plugin descarga ambos con `HttpService` desde `raw.githubusercontent.com` cada vez que el profesor pulsa **Sincronizar**. Actualizar contenido es solo hacer `git push` — no hace falta republicar el plugin.
- **v1.0 no filtra el catálogo por alumno.** Cualquiera que tenga el plugin instalado ve el mismo catálogo completo. El control de acceso por alumno (vía la plataforma del curso) es una versión futura.
- El repositorio es **público** a propósito: el plugin lee los archivos `raw` sin autenticación. El contenido son scripts didácticos, no datos de alumnos.
- **El catálogo evita `ServerScriptService` salvo que sea imprescindible.** La mayoría de los scripts viven dentro de la propia Part a la que afectan (usan `script.Parent`, así que funcionan con cualquier Part sin necesitar nombres especiales), o como script independiente en `Workspace` cuando la mecánica coordina varios objetos a la vez (por ejemplo, un ciclo de día/noche que no pertenece a ninguna Part en particular).

## Instalar para probar (modo local)

1. Copia `src/TimeclubAcademyPlugin.lua` a la carpeta de Plugins de Roblox Studio:
   - Windows: `%LOCALAPPDATA%\Roblox\Plugins\`
2. Abre (o reinicia) Roblox Studio. Aparecerá un botón **"Catálogo de scripts"** en la pestaña Plugins.
3. Al abrir el panel, pulsa **Sincronizar** para cargar el catálogo desde GitHub.

Esto es temporal: cuando el plugin esté validado, se publicará como un Plugin real de Roblox (bajo un Group) para que Roblox lo actualice automáticamente en todas las instalaciones — ver sección "Próximos pasos".

## Estructura del repositorio

```
manifest.json          Catálogo: qué scripts existen, dónde van, qué requieren
scripts/
  m1l4/                 Scripts de Módulo 1, Lección 4
  m1l5/
  m1l7/
  m1l9/
src/
  TimeclubAcademyPlugin.lua   El plugin en sí (UI + lógica de sincronización/inserción)
```

## El esquema de `manifest.json`

Cada entrada de `scripts` describe un script insertable:

| Campo | Significado |
|---|---|
| `id` | Identificador único y estable del script. |
| `module`, `lesson`, `lessonTitle` | A qué lección del curso pertenece. |
| `name`, `description` | Lo que ve el profesor/alumno en el panel. |
| `targetParent` | `"SelectedPart"` (dentro de la Part seleccionada, usa `script.Parent`) o `"Workspace"` (script independiente, para mecánicas que no pertenecen a una sola Part) — dónde se inserta el `Script`. |
| `scriptInstanceName` | Nombre que tendrá el `Script` insertado (se usa también para detectar y reemplazar una inserción anterior). |
| `file` | Ruta relativa del `.lua` dentro de este repo. |
| `requiredObjects` | Lista de instrucciones en español de qué debe crear el alumno a mano antes de insertar (en v1.0 no hay modelos embebidos, solo scripts). |
| `conflictsWith` | IDs de otros scripts que no deben coexistir en el mismo lugar (por ejemplo, dos scripts que controlan `Lighting.ClockTime` a la vez). |
| `tested` | `false` hasta que alguien lo pruebe manualmente en Studio y lo confirme. El panel muestra "⚠ No probado" mientras tanto. |

## Añadir un script nuevo (para futuras lecciones)

1. Crea el archivo `.lua` dentro de `scripts/<lección>/`, con un comentario de cabecera igual al de los scripts existentes: ubicación, requisitos, qué hace.
2. Añade una entrada correspondiente en `manifest.json`.
3. Pruébalo manualmente en Roblox Studio insertándolo con el plugin.
4. Cambia `"tested": false` a `"tested": true` solo después de confirmar que funciona.
5. Haz commit y push. La próxima vez que alguien pulse "Sincronizar" en el plugin, verá el script nuevo — sin reinstalar nada.

## Alcance de esta versión (v1.0)

Incluye únicamente las 4 lecciones del Módulo 1 que tienen scripts documentados: **M1L4, M1L5, M1L7 y M1L9** (14 scripts en total). Quedan fuera de v1.0, explícitamente:

- Módulos 2 y 3 (aún no analizados).
- Lecciones de M1 sin script (M1L1, M1L2, M1L3, M1L6): no necesitan catálogo.
- M1L8 y M1L10: sus scripts adicionales viven en una plataforma externa (`mars.alg.academy`) a la que todavía no tenemos acceso al contenido real.
- Modelos, Parts o efectos embebidos en el plugin — v1.0 es solo scripts + instrucciones de qué construir a mano.
- Control de acceso por alumno (gating vía backend).

## Próximos pasos (fuera de v1.0)

- Probar cada script en Roblox Studio y marcarlo `"tested": true`.
- Publicar el plugin como Plugin real de Roblox (bajo un Group de la academia), no listado, para que se actualice solo en las máquinas de los alumnos.
- Conectar el catálogo al backend de la academia para filtrar por alumno/lección habilitada (gating).
- Analizar Módulos 2 y 3, y ampliar el catálogo.
- Evaluar soporte para modelos/Parts embebidos, no solo scripts.
