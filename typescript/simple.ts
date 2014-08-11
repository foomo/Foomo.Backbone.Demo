

class SimpleView extends Backbone.View<Backbone.Model> {
	initialize(options) {
		this.$el.html(options.template({}));
		this.model = new Backbone.Model();

		// map components to your views.$el
		Backbone.Components.mapToView(this, [
			// look at all spans if they have an data-model-attr attribute and map them, if so
			Backbone.Components.Display.map('span'),
			// look for form input elements and map them to your model based on their name
			Backbone.Components.Controls.Input.map('input')
				// add a behaviour to fire change events, with every key up
				.addBehaviour(Backbone.Components.Controls.Behaviours.TypeToChange.factory)
		]);

		this.model.set('name', 'World');
	}
}
