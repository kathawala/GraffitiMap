# GraffitiMap
An R/Shiny webapp which let's you look at reported incidents of graffiti within a selected timeframe in San Francisco

[Try it out!](http://ec2-54-243-26-197.compute-1.amazonaws.com:3838/)

## Screenshots

![Clean Start Page](http://i.imgur.com/HKhYZz9.jpg)
![Basic Usage](http://i.imgur.com/ky8iFFs.jpg)
![Image Viewing Functionality](https://i.imgur.com/AFGUKtj.jpg)

## Usage

To use the app you'll need `R` and `bash` at the bare minimum.

This setup script downloads the entire Case Data file from the SF 311 Government website, so it might take a while since the file is pretty large.
Run the following and maybe take a stretch break while everything sets up.

```bash
git clone https://github.com/kathawala/GraffitiMap.git
cd GraffitiMap
bash setupApp
```

It's a one-time setup! Once that's good and done, you can start up the app with the following command

```bash
bash runApp
```

After running that, you should see something like the following appear in your terminal

`Listening on http://127.0.0.1:6692`

Go ahead and paste that URL in your web browser and enjoy :)
