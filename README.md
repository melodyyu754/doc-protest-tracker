# Sample App for 2024 DoC

## Changelog
- 9 Feb 2024:
  - Reconfigured Docker setup to have top-level Dockerfile for fly.io
  - Set up auto deploy to fly.io via github actions when pushing to main
    - Note that once you push to main, it will take up to a couple minutes for the changes to take affect on the public website

- 8 Feb 2024:
  - Added an additional "service" of REST API build using Flask.  There are only 2 simple GET endpoints
  - Updated the Streamlit app to have multiple pages, show a couple other demos, and hit the above REST API if running
  - Some code reorganization and tidying up
  - **Important**: Note the change of the command to run the Streamlit app. 

## About

This is a sample app being developed for the Summer 2024 DoC in Leuven, Belgium titled Data and Software in International Government and Politics.

Currently, there are two major components:
- Streamlit App (in the `/app` directory)
- Flask REST api (in the `/api` directory)


## Getting Started for the Streamlit App

1. Move into the app folder with `cd app`

2. In your preferred python environment (or you can create a new one), install the python dependencies. 

```bash
pip install -r src/requirements.txt
```

3. Run the Streamlit app locally by executing the following command (if you get an error, you may need to reload your shell/terminal for it to find the `streamlit` executable):

```bash
streamlit run src/Home.py
```
## REST API in Docker

- More to come

## To Do:

- [ ] Devlop an example ML service that can perform some type of real-time inferencing. (Maybe just start off with like random number generator or something)
- [ ] Dockerize the ML App
- [ ] Automate deployment with Actions
- [ ] Find out about deploying multiple containers to Fly.io from 1 repo. Is that possible?
- [ ] Find out what the AWS equivalent of Fly.io is
