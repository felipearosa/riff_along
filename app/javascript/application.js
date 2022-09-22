// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import { runGTM } from './src/rungtm.js'

runGTM();
