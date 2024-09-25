#  AI provider flutter app
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)]()
[![Maintaner](https://img.shields.io/static/v1?label=Oleksandr%20Samoilenko&message=Maintainer&color=red)](mailto:oleksandr.samoilenko@extrawest.com)
[![Ask Me Anything !](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)]()
![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)
![GitHub release](https://img.shields.io/badge/release-v1.0.0-blue)

## PROJECT INFO
- **Youtube video and website summarization app on Groq AI**
- **We were intended to create a an MVP showcase application that allows to summarize Youtube video and website summarization with the help of groq.ai**

## Features
- Groq with "llama3-8b-8192"

## Installing:
**1. Clone this repo to your folder:**

```
git clone https://gitlab.extrawest.com/i-training/flutter/unisummarizer-saas
```

**2. Change current directory to the cloned folder:**

```
cd unisummarizer-saas/app
```

**3. Get packages**

```
flutter pub get
```
## Setup Server
**1. Open server folder:**

```
cd unisummarizer-saas/server
```
**2. Change port number :**

const port = YOUR_PORT_NUMBER;

**2. Change server path in flutter project:**
Go to app/lib/services/api.dart and change the baseUrl to your server path

Now you can use the app

## Preview

![Preview](https://gitlab.extrawest.com/i-training/flutter/unisummarizer-saas/-/blob/main/demo_files/web-summarize.mp4)
![Preview](https://gitlab.extrawest.com/i-training/flutter/unisummarizer-saas/-/blob/main/demo_files/youtube-summarize.mp4)

Created by Oleksandr Samoilenko

[Extrawest.com](https://www.extrawest.com), 2024
