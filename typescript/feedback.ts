// some imports

import Behaviours = Backbone.Components.Behaviours;
import Controls = Backbone.Components.Controls;
import Validation = Backbone.Components.Behaviours.Validation;
import Validators = Backbone.Components.Behaviours.Validation.Validators;

class SimpleModel extends Backbone.Model {
	/**
	 * the idea is to attach a model for feedback and the run validation,
	 * which give feedback to it
	 */
	public feedback:Behaviours.FeedbackModel;
	constructor() {
		this.feedback = new Behaviours.FeedbackModel;
		super();
	}
	set() {
		// force custom auto validation
		var ret = super.set.apply(this, arguments);
		this.customValidate();
	}
	customValidate() {
		return Validation.Validator.create(this, this.feedback)
			.chain(
				// validate the attributes name, zip with the empty validator
				Validators.EmptyValidator.pack('name', 'zip'),
				// configure the length validator and use it on name
				Validators.LengthValidator.pack(4, 8, 'name'),
				// configure the length validator and use it on zip
				Validators.LengthValidator.pack(5, 5, 'zip')
			)
			?null:'aaaaa'
		;
	}
}

class FeedbackView extends Backbone.View {
	model: SimpleModel;
	constructor(options) {
		// boilerplate
		super(options);
		this.model = new SimpleModel();
		this.$el.html(options.template({}));

		// "localize" messages
		Validators.EmptyValidator.MESSAGES = {
			OK : 'awesome',
			MUST_NOT_BE_EMPTY : 'do not leave me empty'
		}

		// map components with behaviours
		Backbone.Components.mapToView(this, [
			Backbone.Components.Display.map('span'),
			Controls.Input.map('.controlWithFeedback')
				// fire changes, as we type
				.addBehaviour(Controls.Behaviours.TypeToChange.factory)
				// add feedback behaviour
				.addBehaviour(Behaviours.ComponentFeedback.getFactory(this.model.feedback))
		]);
	}
}
