class MyCompsView extends Backbone.View<Backbone.Model> {
	/**
	 * this is a very nice use of typescript
	 */
	private components:{
		displayA?:Backbone.Components.Display;
		displayB?:Backbone.Components.Display;
		myInput?:Backbone.Components.Controls.Input;
		myOtherInput?:Backbone.Components.Controls.Input;
	};
	constructor(options) {
		super(options);
		this.$el.html(options.template({}));
		this.model = new Backbone.Model();

		// map components and resolve according to their ids
		this.components = Backbone.Components.mapToView(this, [

			// this will return displayA and displayB
			// identified by their id
			Backbone.Components.Display.map('div.display'),

			// this will return myInput and myOtherInput
			// identified by guess what ;)
			Backbone.Components.Controls.Input.map('input')
		]);

		// magic happened - the instances are mapped, we can use them
		this.components.myInput.setValue('My input');
		this.components.myOtherInput.setValue('My other input');

		this.components.displayA.setValue('Display A');
		this.components.displayB.setValue('Display B');

	}
}
