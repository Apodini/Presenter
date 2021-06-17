
#if canImport(JavaScriptCore)
import JavaScriptCore
#endif

public struct JavaScriptAction: Action {

    // MARK: Stored Properties

    private var inputKeys: [String]
    private var inputNames: [String]
    private var script: String
    private var resultKey: String
    private var errorKey: String

    // MARK: Initialization

    public init(script: String,
                inputs: [ScriptInput],
                resultKey: String,
                errorKey: String) {
        self.script = script
        self.inputKeys = inputs.map(\.stateKey)
        self.inputNames = inputs.map(\.variableName)
        self.resultKey = resultKey
        self.errorKey = errorKey
    }

    // MARK: Methods

    #if canImport(SwiftUI)

    public func perform(on model: Model) {

        #if canImport(JavaScriptCore)

        guard let context = JSContext() else {
            return assertionFailure()
        }

        context.exceptionHandler = { context, value in
            model.state[errorKey] = value?.toObject()
        }

        for (key, name) in zip(inputKeys, inputNames) {
            context.setObject(model.state[key], forKeyedSubscript: name as NSString)
        }

        let functionName = "$_xyz_abc_javascript_action_main_function_cba_xyz_$_$"
        context.evaluateScript("function " + functionName + "() {\n" + script + "\n}")
        model.state[resultKey] = context
            .objectForKeyedSubscript(functionName)
            .call(withArguments: [])
            .toObject()

        #else

        // Not possible as of now - but is only relevant for watchOS

        #endif

    }

    #endif

}

extension JavaScriptAction {

    public struct ScriptInput: ExpressibleByStringLiteral {

        // MARK: Stored Properties

        public var stateKey: String
        public var variableName: String

        // MARK: Initialization

        public init(stateKey: String, variableName: String) {
            self.stateKey = stateKey
            self.variableName = variableName
        }

        public init(stringLiteral value: String) {
            self.stateKey = value
            self.variableName = value
        }

    }

}
