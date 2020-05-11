export tag Pokemon
	prop random_value default: Math.random()
	prop pokemon_data

	def load params
		@random_value = Math.random()
		await data.load_pokemon_detail params:name
		@pokemon_data = data.states:pokemon_detail
		console.log @pokemon_data

	def random_value_from array
		array[Math.floor(@random_value * array:length)]

	def render
		const main_type = @pokemon_data:types[0]:type:name
		<self.type.{main_type}>
			<div.title.type.{main_type}.dark-color>
				<img src=@pokemon_data:sprites:front_default>
				<div>
					<h2> "{@pokemon_data:name} (Nº {@pokemon_data:national_dex_number})"
					<h3> "the {@pokemon_data:genera:genus}"
					<ul.types>
						for type_data in @pokemon_data:types
							<li.type.{type_data:type:name}> type_data:type:name
			<Description[random_value_from(@pokemon_data:flavor_text_entries)]>
			<div.content>
				<Abilities[@pokemon_data:abilities].type.{main_type}.light-color>
				<Stats[@pokemon_data:stats].type.{main_type}.light-color>
				<Misc[@pokemon_data].type.{main_type}.light-color>

tag Description
	def clean text
		text = text.replace(/\s+/g, ' ')
		let sentences = for sentence in text.split('.')
			sentence = sentence.trim
			sentence ? "{sentence[0].toUpperCase()}{sentence.slice(1).toLowerCase()}" : ''
		sentences.join('. ')

	def render
		<self>
			<h2> "Pokemon {data:version:name.replace('-', ' ')} Pokedex Entry"
			<p> clean data:flavor_text

tag Abilities
	def render
		<self>
			<section>
				<h2> 'Abilities'
				<br>
				<ul.abilities>
					for ability_data in data
						<li.ability> 
							<span>
								"{ability_data:ability:name.replace('-', ' ')}"
							<span>
								"{ability_data:is_hidden ? '(hidden)' : ''}"
tag Stats
	def render
		<self>
			<section>
				<h2> 'Combat Stats'
				<br>
				<ul.stats>
					for stat_data in data
						<li.stat> 
							<span>
								"{stat_data:stat:name.replace('-', ' ')}:"
							<span>
								"{stat_data:base_stat} {"(EV: {stat_data:effort})"}"

tag Misc
	def render
		<self>
			<section>
				<h2> 'General Stats'
				<br>
				<ul.stats>
					<li.stat> 
						<span>
							"weight:"
						<span>
							"{data:weight}"
					<li.stat> 
						<span>
							"shape:"
						<span>
							"{data:shape:name}"
					<li.stat> 
						<span>
							"generation:"
						<span>
							"{data:generation:name.split('-')[1]}"
					<li.stat> 
						<span>
							"growth rate:"
						<span>
							"{data:growth_rate:name.replace('-', ' ')}"