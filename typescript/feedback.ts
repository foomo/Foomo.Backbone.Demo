module Demo {
	
	import Behaviours = Backbone.Components.Behaviours;
	import Components = Backbone.Components;
	import Controls = Backbone.Components.Controls;
	
	export class SimpleModel extends Backbone.Model {
		public feedback:Behaviours.FeedbackModel;
		constructor(defaults?) {
			super(defaults);
			this.feedback = new Behaviours.FeedbackModel;
			this.on('change', this.test, this);
		}
		test() {
			var foo = this.get('foo');
			if(foo.length == 0) {
				this.feedback.giveFeedback(
					'foo',
					'must not be empty',
					Behaviours.Feedback.LEVEL_ERROR
				);
			} else {
				this.feedback.giveFeedback(
					'foo',
					'',
					Behaviours.Feedback.LEVEL_OK
				);

			}
		}
		default() {
			return {
				foo:'Hello',
				bar: '',
				options: ['a', 'b', 'c']
			};
		}

	}

	export class SimpleView extends Backbone.View {
		model: SimpleModel;
		components: {
			inputFoo?:Controls.Input;
			selectBar?:Controls.Select;
			displayFoo?:Components.Display;
		};
		constructor(options) {
			super(options);
			this.model = new SimpleModel();
			// this.setElement($('body'));
			this.$el.html(options.template({}));
			this.components = Backbone.Components.mapToView(this, [
				Components.Display.map('h1'),
				Components.Display.mapWithFilter('div span.filter-object', (data:any) => {
					var ret = '- not set -';
					_.each(this.model.get('options'), (option:{value:any; label:string;}) => {
						if(data == option.value) {
							ret = option.label;
						}
					});
					return ret;
				}),
				Controls.Input.map('div')
					.addBehaviour(Controls.Behaviours.TypeToChange.factory)
					.addBehaviour(Behaviours.ComponentFeedback.getFactory(this.model.feedback))
				,
				Controls.Select.mapWithOptionsFrom('div', this.model, 'options')
			]);
			this.components.displayFoo.filter = (data:any) => {
				return data?data:'--<b>hhh</b>--';
			}
		}
	}	
}
