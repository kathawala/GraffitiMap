# GraffitiMap
An R/Shiny webapp which let's you look at reported incidents of graffiti within a selected timeframe in San Francisco

## Screenshots

![Start Page](http://imgur.com/HKhYZz9)
![Date Selection](http://imgur.com/62SNI96)
![Tooltip Usage](http://imgur.com/ky8iFFs)

## Usage

To use the app you'll need `R` and `bash` at the bare minimum.

This setup script downloads the entire Case Data file from the SF 311 Government website, so it might take a while since the file is pretty large.
Run the following and maybe take a stretch break while everything sets up.

```bash
git clone https://github.com/kathawala/GraffitiMap.git
cd GraffitiMap
Rscript --vanilla pkg_install.R
bash setupApp
```

It's a one-time setup! Once that's good and done, you can start up the app with the following command

```bash
bash runApp
```

After running that, you should see something like the following appear in your terminal

`Listening on http://127.0.0.1:6692`

Go ahead and paste that URL in your web browser and enjoy :)

## TODOs

I notice that for some of the graffiti in the SF 311 Case Data file there are URLs where one can grab a photo of the graffiti.
Next step is definitely to have that appear in the tooltip when someone clicks on the markers on the map.
