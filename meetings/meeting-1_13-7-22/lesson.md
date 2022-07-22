# Tool Scrubbers Guild - Lesson 1
![](https://i.imgur.com/UO31BE1.png)

### Prerequisites

- VSCode
- Computer with 4 core, 8GB Ram
- Some basic CLI experience
- Github Account

## Set up Environment


1. Download [VSCode](https://code.visualstudio.com/)
2. Install [Rust Formatter](https://code.visualstudio.com/docs/languages/rust)
3. Sign up to [Github](https://github.com/signup?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home) 
> Read through the whole page, this will give some great pointers on Rust development


## Download 0L 
> Open up terminal and follow the  commands

4. Fork the Libra repo
`https://github.com/OLSF/libra/fork`
5. Download the newly forked Github repo
`git clone https://github.com/<YOUR USER ACC>/libra`
6. Create a new branch for your changes
`git checkout -b clean-up-syntax`
7. Open up VSCode, navigate to file > open folder and open your newly created repo 
8. Run Rust Formatter 
`rustfmt <PATH TO THE FILE YOU WANT TO FORMAT>`
9. Check the changes that were made
`git diff`

## Push to Github
10. Add changes
`git add .`
11. Commit changes
`git commit -m 'format folders'`
12. Push changes
`git push --set-upstream origin clean-up-syntax`

> On the left hand side of the image above. You will see a red box. This is the contents of the `ol` folder in the root of the libra repo. This contains most of the tools that are currently build and that we will be working to fine tune and add to.lesson
