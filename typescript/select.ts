class SelectView extends Backbone.View<Backbone.Model> {
	constructor(options:any) {
		super();
		this.setElement(options.el);
		this.$el.html(options.template({}));
		console.log(options.template({}), this.$el);
		this.model = new Backbone.Model({options: []});

		// map components to your views.$el
		Backbone.Components.mapToView(this, [
			Backbone.Components.Controls.Select.mapWithOptionsFrom('.control', 'options', this.model)
		]);

	}
}
