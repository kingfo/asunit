package asunit.framework {

	import asunit.asserts.*;
	
	public class InjectionDelegateTest  {
		
		[Inject]
		public var injector:InjectionDelegate;
		
		[Test]
		public function testInstantiated():void {
			assertTrue("instance is InjectionDelegate", injector is InjectionDelegate);
		}

		[Test]
		public function testUpdateInjectionPoints():void {
			var addict:Addict = new Addict();
			injector.updateInjectionPoints(addict);
			assertNotNull(addict.array);
		}
		
		[Test(expects="asunit.errors.UsageError")]
		public function shouldThrowUsageErrorOnInvalidAddict():void
		{
			var invalidAddict:AddictWithNoInjections = new AddictWithNoInjections();
			injector.updateInjectionPoints(invalidAddict);
		}
		
		[Test(expects="asunit.errors.UsageError")]
		public function shouldThrowUsageErrorIfNoVariableInjectionsFound():void
		{
			var invalidAddict:AddictWithOnlyMethodInjection = new AddictWithOnlyMethodInjection();
			injector.updateInjectionPoints(invalidAddict);
		}
		
	}
}

//An addict that has no inject annotations
class AddictWithNoInjections {}

class AddictWithOnlyMethodInjection {
	[Inject]
	public function pleaseInjectMe(array:Array):void{};
}

class Addict {
	[Inject]
	public var array:Array;
	
	[Inject]
	public function pleaseInjectMe(array:Array):void{};
}