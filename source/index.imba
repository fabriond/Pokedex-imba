import { App } from './components/App'
import { Stores } from './controllers/Store'

const state = Stores.new()

Imba.mount <App[state]>