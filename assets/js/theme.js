let toggleTheme = (theme) => {
  if (theme == "dark") {
    setTheme("light");
    loadParticles("light")
  } else {
    setTheme("dark");
    loadParticles("dark")
  }
}

let setTheme = (theme) =>  {
  transTheme();
  if (theme) {
    document.documentElement.setAttribute("data-theme", theme);
  }
  else {
    document.documentElement.removeAttribute("data-theme");
  }
  localStorage.setItem("theme", theme);
  
  if (typeof medium_zoom !== 'undefined') {
    medium_zoom.update({
      background: getComputedStyle(document.documentElement)
          .getPropertyValue('--global-bg-color') + 'ee',
    })
  }
};


let transTheme = () => {
  document.documentElement.classList.add("transition");
  window.setTimeout(() => {
    document.documentElement.classList.remove("transition");
  }, 500)
}


let initTheme = (theme) => {
  if (theme == null) {
    const userPref = window.matchMedia;
    if (userPref && userPref('(prefers-color-scheme: dark)').matches) {
        theme = 'dark';
    }
  }
  setTheme(theme);
}


initTheme(localStorage.getItem("theme"));

let loadParticles = (theme) => {
  var matches = document.baseURI.match(/\//g); 
  var count = matches ? matches.length : 0;
  if (count != 3)
    return;
  
  if (!theme)
    setParticles(localStorage.getItem("theme"))
  else
    setParticles(theme)
}

let setParticles = (theme) => {
  if (theme == "dark") {
    try {
      particlesJS.load('particles-js', 'assets/json/particles-dark.json');
    } catch(e) {
      console.log('ERROR: particles-js is not loaded.')
    }
  }
  else {
    try {
      particlesJS.load('particles-js', 'assets/json/particles-light.json');
    } catch(e) {
      console.log('ERROR: particles-js is not loaded.')
    }
  }
}