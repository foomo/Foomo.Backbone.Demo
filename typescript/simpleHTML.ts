class SimpleHTMLView extends Backbone.View<Backbone.Model> {
	initialize(options) {
		this.$el.html(options.template({}));
		this.model = new Backbone.Model();

		// escape yourself!
		Backbone.Components.mapToView(this, [
			// look at all spans if they have an data-model-attr attribute and map them, if so
			Backbone.Components.DisplayHTML.map('span'),
		]);

		this.model.set('name', '<b>World</b>');
	}
}
