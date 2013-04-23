

class SimpleView extends Backbone.View {
	constructor(options) {
		super(options);
		this.$el.html(options.template({}));
		this.model = new Backbone.Model();
		Backbone.Components.mapToView(this, [
			Backbone.Components.Display.map('span'),
			Backbone.Components.Controls.Input.map('input')
				.addBehaviour(Backbone.Components.Controls.Behaviours.TypeToChange.factory)
		]);
		this.model.set('name', 'World');
	}
}
