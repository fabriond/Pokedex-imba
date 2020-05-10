export class Stores
	prop states
	
	def initialize
		@states = {}

	def load_more_pokemon
		console.log "Fetching More Pokemon... ({(@states:pokemon_list or []):length} so far)"
		const response = await window.fetch(@states:next_url or 'https://pokeapi.co/api/v2/pokemon/?limit=15')
		const json_data = await response.json
		@states = {
			pokemon_list: (@states:pokemon_list or []).concat(map_pokemon(json_data:results)), 
			next_url: json_data:next, 
			filter: (@states:filter or '')
		}

	def filtered_list
		@states:pokemon_list.filter do $1:name.includes(@states:filter.toLowerCase())

	def load_pokemon_detail pokemon_name
		console.log "Fetching Data for {pokemon_name}"
		const json_data = {}

		const pokemon_data = await window.fetch("https://pokeapi.co/api/v2/pokemon/{pokemon_name}")
		Object.assign(json_data, await pokemon_data.json)
		
		const species_data = await window.fetch("https://pokeapi.co/api/v2/pokemon-species/{pokemon_name}")
		Object.assign(json_data, await species_data.json)

		json_data:flavor_text_entries = json_data:flavor_text_entries.filter do $1:language:name === 'en'
		json_data:genera = (json_data:genera.filter do $1:language:name === 'en')[0]
		json_data:types = json_data:types.sort do $1:slot > $2:slot
		json_data:national_dex_entry = json_data:pokedex_numbers.filter do $1:pokedex:name === 'national'
		json_data:national_dex_number = json_data:national_dex_entry[0]:entry_number
		json_data:stats = json_data:stats.reverse
		@states = {pokemon_detail: json_data}

	def map_pokemon pokemon_summary
		for pokemon in pokemon_summary
			let id = pokemon:url.split('/')
			id.pop()
			{id: id.pop(), name: pokemon:name}