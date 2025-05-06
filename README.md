# Rename Exported Mac Photos

Apple's **Photos** app lets you export photos and videos. However it organises them into folders labelled with the date or the 'moment' and the date in such a way that you can't sort them by date.

This app takes the exported format:
- `27 February 2025`
- `Home, 31 May 2024`
- `Ashton Gate Stadium, 7 March 2025`

and converts it to ISO date format, making it alphabetically sortable:
- `2025-02-27`
- `2024-05-31, Home`
- `2025-03-07, Ashton Gate Stadium`

## How to build

This is a **Qt app** for Qt 6.5+, using CMake, C++ and QML.

The simplest way to build it is to use the Qt Online Installer to install the **Qt Creator** IDE and your chosen version of Qt.

1. In **Qt Creator** open `CMakeLists.txt` which will load the project. You will need to select the configurations you want to support (eg. Debug, Release etc.).
2. Click **Run**, which will run CMake, perform the build and run the app.

## How to use

1. Use the **Photos** app to select your photos, then **File > Export**.
2. In the popup, select your options. In the **File Naming** section, set **Subfolder Format** to **Moment Name**. Then click **Export** and select/create a destination folder.
3. Within that folder, you'll see folders labelled either `Date` or `Moment, Date` as described above.
4. Open the **Rename Exported Mac Photos** app.
5. Initially the path field contains `/Users`. Assuming your destination is within your user space, click **Set path**, and the left panel will populate with all the folders.
6. Click the folder you want to open. This will append it to the path. Click **Set path** to open that path and list its contents (only the folders will be listed).
7. In this way, navigate to the folder that contains all the exports. The left panel should now show all those folders labelled `Date` or `Moment, Date`.
8. Click **Test conversion** to see what all the folders will be renamed to on the right panel. At this point, nothing has changed in your folder.
9. If it's what you want, click **Do conversion** to instantly rename all the folders. The left panel now shows the folders, post-conversion.
