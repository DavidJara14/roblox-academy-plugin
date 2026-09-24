# Timeclub Academy — Plugin de Roblox Studio (v5.4.0)

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
  m2l2/ m2l3/ m2l4/ m2l6/ m2l7/ m2l8/ m2l9/    Módulo 2
  m3l1/ m3l2/ m3l3/                             Módulo 3
  m4l1/ m4l2/ m4l3/ m4l4/                       Módulo 4
  m5l1/ m5l2/ m5l3/                             Módulo 5
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
| `targetParent` | `"SelectedPart"` (dentro del objeto seleccionado, usa `script.Parent` — funciona con cualquier Part, Folder, ClickDetector, Frame, etc.), `"Workspace"`, `"ServerScriptService"` o `"StarterPlayerScripts"` — dónde se inserta el script. `ServerScriptService`/`StarterPlayerScripts` solo se usan cuando la mecánica es global de verdad (ver [[feedback-plugin-architecture]] en la memoria del proyecto). |
| `scriptClassName` | `"Script"` (por defecto si se omite), `"LocalScript"` (mecánicas de UI/cliente) o `"ModuleScript"` (código reutilizable con `require`, como `AudioPlayer` de M4L4). |
| `scriptInstanceName` | Nombre que tendrá el script insertado (se usa también para detectar y reemplazar una inserción anterior, y a veces otros scripts lo buscan por este nombre exacto — ver `notes` de cada entrada). |
| `startDisabled` | `true` si el script debe insertarse deshabilitado (plantillas que otro script clona, como `CoinCollectScript`). |
| `file` | Ruta relativa del `.lua` dentro de este repo. |
| `requiredObjects` | Lista de instrucciones en español de qué debe crear/seleccionar el alumno a mano antes de insertar (no hay modelos embebidos, solo scripts). |
| `conflictsWith` | IDs de otros scripts que no deben coexistir en el mismo lugar (por ejemplo, dos scripts que controlan `Lighting.ClockTime` a la vez). |
| `tested` | `false` hasta que alguien lo pruebe manualmente en Studio y lo confirme. El panel muestra "⚠ No probado" mientras tanto. |

## Añadir un script nuevo (para futuras lecciones)

1. Crea el archivo `.lua` dentro de `scripts/<lección>/`, con un comentario de cabecera igual al de los scripts existentes: ubicación, requisitos, qué hace.
2. Añade una entrada correspondiente en `manifest.json`.
3. Pruébalo manualmente en Roblox Studio insertándolo con el plugin.
4. Cambia `"tested": false` a `"tested": true` solo después de confirmar que funciona.
5. Haz commit y push. La próxima vez que alguien pulse "Sincronizar" en el plugin, verá el script nuevo — sin reinstalar nada.

## Alcance de esta versión (v5.0.0)

Incluye Módulos 1 a 5 del curso (el curso podría continuar más allá — ver "Próximos pasos"):
- **Módulo 1**: M1L4, M1L5, M1L7, M1L9 (19 scripts).
- **Módulo 2**: M2L2, M2L3, M2L4, M2L6, M2L7, M2L8, M2L9 (22 scripts).
- **Módulo 3**: M3L1, M3L2, M3L3 (11 scripts).
- **Módulo 4**: M4L1, M4L2, M4L3, M4L4 (11 scripts).
- **Módulo 5**: M5L1, M5L2, M5L3 (7 scripts).

Quedan fuera, explícitamente:

- Lecciones sin script (M1L1/2/3/6, M2L1/M2L5/M2L10, M3L4): no necesitan catálogo (M3L4 es solo configuración de Properties, sin código).
- M1L8, M1L10, y las tiendas de M2L10/M3L4/M4L4: sus scripts adicionales viven en plataformas externas (`mars.alg.academy` / `learn.alg.academy`) a las que no tenemos acceso al contenido real.
- **El sistema de disparo del jugador de M5L2/M5L3** (`WeaponHandler`, `WeaponRemote`, `WeaponScript`, y el botón de disparo móvil): a diferencia de todo lo demás en el catálogo, el material fuente solo muestra fragmentos de código anotados, nunca el script completo — no se pudo reconstruir sin inventar lógica. Ver `reportes/M5/M5L2-reporte.md` para el detalle.
- Modelos, Parts o efectos embebidos en el plugin — es solo scripts + instrucciones de qué construir a mano.
- Control de acceso por alumno (gating vía backend).

**Nota sobre M2L8**: es un sistema de 4 scripts interdependientes (spawn de enemigos + IA de persecución + combate) que comparten una jerarquía específica de Folders — no son piezas sueltas intercambiables como el resto del catálogo. Ver `reportes/M2/M2L8-reporte.md` en el proyecto de análisis para el detalle completo, incluidos 2 bugs reales corregidos del material original.

**Nota sobre Módulo 3 (shooter)**: la lección enseña la mecánica de disparo en 3 capas progresivas que **no se combinan, se reemplazan**: `m3l1-arma-basica` (sin daño, un jugador) → `m3l2-arma-con-objetivo` (con daño, un jugador) → `m3l3-pistola-cliente` + `m3l3-crear-bala-servidor` (multijugador real vía RemoteEvent). El catálogo marca estas tres como `conflictsWith` entre sí. `m3l3-crear-bala-servidor` corrige un bug real del material original (humo/fuego y la bala se parentaban al arma en vez de volar libres en Workspace). Ver `reportes/M3/` en el proyecto de análisis para el detalle completo.

**Nota sobre Módulo 4 (simulador de carreras)**: `m4l2-iniciar-carrera` corrige un bug real del temporizador (creaba un valor nuevo en ServerStorage cada vuelta en vez de reemplazar el anterior, corrompiendo el tiempo a partir de la 2ª vuelta). `m4l3-controlador-todoterreno` corrige un `wait()` redundante que procesaba el input del vehículo a mitad de velocidad al girar. `m4l4-audio-player` es el primer `ModuleScript` del catálogo (código reutilizable vía `require`, no una mecánica insertable directamente). Ver `reportes/M4/` en el proyecto de análisis para el detalle completo.

**Nota sobre Módulo 5 (arcade espacial)**: el personaje de esta lección es una nave 100% construida con Parts, **sin objeto `Humanoid`** — por eso `m5l2-touch-script` filtra por nombre de Part en vez de buscar un Humanoid (es lo correcto para este rig, no una excepción a la convención del catálogo). `m5l1-player-ship-handler` y `m5l2-touch-script` ya incluyen la tabla de clasificación (Score/Loose) que M5L3 añade sobre la base de M5L1/M5L2 — son la versión final de cada script, no hace falta insertar una versión intermedia primero. El sistema de disparo del jugador (M5L2/M5L3) queda fuera del catálogo — ver arriba. Ver `reportes/M5/` en el proyecto de análisis para el detalle completo.

**v5.1.0 — correcciones de David tras probar Módulo 1 en Studio**: `m1l5-cambiar-color-y-tamano-al-tocar` cambiaba el tamaño en el eje incorrecto (achataba X en vez de Y); `m1l5-emitir-particulas-al-tocar` pedía un efecto "Sparkles" que no existe, es "ParticleEmitter"; `m1l5-trampa-mortal` se renombró a `m1l5-insta-kill`; `m1l7-luz-de-calle-nocturna` y `m1l7-parpadeo-de-luces` pasaron de ser scripts independientes en Workspace (con `Workspace:WaitForChild(nombre)`) a vivir dentro de un Model/Folder que agrupa sus Parts, usando `script.Parent` — mismo patrón preferido que el resto del catálogo. Además, **nueva convención**: los scripts ya no usan `WaitForChild` para acceder a objetos que el alumno ya creó a mano antes de insertar (siempre están presentes, así que agregar `WaitForChild` solo añade complejidad innecesaria para los chicos) — se reserva `WaitForChild` únicamente para casos con una demora real (el personaje cargando, un RemoteEvent replicándose desde el servidor, `leaderstats` creado por otro script). Todos los scripts de Módulo 1 ahora incluyen una sugerencia de "Para experimentar" con propiedades para que los alumnos prueben cambiar (Brightness, Rate, colores, etc.).

**v5.2.0 — David aprobó M1L5 y M1L7 tras probarlos; feedback sobre M1L9**: `m1l9-aparicion-de-objeto` rediseñado — el Model ahora se coloca directamente dentro de ServerStorage desde el inicio (ya no hay que "esconderlo" moviéndolo al arrancar), y el script pasa a vivir dentro de la Part disparadora (`script.Parent`, `targetParent: SelectedPart`) en vez de ser un script independiente en Workspace que buscaba la Part por nombre — ya no importa cómo se llame el disparador. **Nueva convención**: en vez de `local X = game:GetService("NombreDelServicio")`, se usa `game.NombreDelServicio` directamente donde se necesite (más simple de leer para los chicos) — aplicado a todos los scripts de Módulo 1 que tocaban `ServerStorage`, `Workspace`, `Lighting` o `Players`.

**v5.3.0 — David pidió simplificar las verificaciones de Humanoid**: los scripts que solo usaban `character:FindFirstChild("Humanoid")` como filtro (sin usar el Humanoid para nada más) ahora solo comprueban que `hit.Parent` exista — reaccionan a cualquier contacto físico, no solo a personajes, a cambio de un código más corto y fácil de leer para los alumnos. Esto **no** aplica a scripts que sí necesitan el objeto Humanoid para funcionar (`m1l5-insta-kill`, `m1l9-dano-por-fuego`: llaman a `humanoid.Health`/`humanoid:TakeDamage()`, ahí el chequeo sigue siendo necesario). `m1l9-fuego-al-acercarse` y `m1l9-fuego-al-acercarse-y-alejarse` además pasaron a vivir dentro de la Part de la antorcha (`script.Parent.Fire`) en vez de buscar "Torch" por nombre en Workspace.

**v5.4.0 — barrido retroactivo de las 3 convenciones a Módulos 2 y 3**: David pidió (2026-09-24) aplicar de una vez, a todo M2/M3, las tres convenciones que fue confirmando sobre Módulo 1 (evitar `WaitForChild` para objetos ya colocados a mano, `game.Servicio` en vez de `GetService`, y simplificar los chequeos de Humanoid que son solo un filtro). 16 scripts actualizados. `WaitForChild` se mantuvo donde sí hace falta (RemoteEvents creados en tiempo de ejecución, personaje cargando) — cada caso quedó comentado con una nota explicando por qué. Módulos 4 y 5 quedan pendientes para un barrido similar.

## Próximos pasos (fuera de v5.4.0)

- Probar cada script en Roblox Studio y marcarlo `"tested": true` (todo el catálogo, incluidos Módulos 3 a 5, sigue sin confirmación manual).
- **Conseguir el código completo del sistema de disparo de M5L2/M5L3** (`WeaponHandler`/`WeaponRemote`/`WeaponScript` + botón de disparo móvil) — desde `learn.alg.academy` o un proyecto de referencia armado en Studio — para poder catalogarlo.
- Verificar si existe un Módulo 6 o el "examen final" que anuncia el cierre de M5L3 antes de asumir que el curso termina en M5.
- Publicar el plugin como Plugin real de Roblox (bajo un Group de la academia), no listado, para que se actualice solo en las máquinas de los alumnos.
- Conectar el catálogo al backend de la academia para filtrar por alumno/lección habilitada (gating).
- Evaluar soporte para modelos/Parts embebidos, no solo scripts.
