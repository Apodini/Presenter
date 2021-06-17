
import Foundation

struct DefaultPlugin: Plugin {

    var views: [_CodableView.Type] {
        [
            AngularGradient.self,
            Button.self,
            Capsule.self,
            Circle.self,
            Color.self,
            ColorPicker.self,
            ComposedView.self,
            DataView.self,
            Divider.self,
            HGrid.self,
            HStack.self,
            If.self,
            Image.self,
            LinearGradient.self,
            Link.self,
            Local.self,
            NavigationLink.self,
            NavigationView.self,
            Nil.self,
            Path.self,
            ScrollView.self,
            Section.self,
            SecureField.self,
            Slider.self,
            Spacer.self,
            TabView.self,
            Text.self,
            TextEditor.self,
            TextField.self,
            Toggle.self,
            VGrid.self,
            VStack.self,
            ZStack.self,
        ]
    }

    var viewModifiers: [AnyViewModifying.Type] {
        [
            AccentColor.self,
            AnimationModifier.self,
            AspectRatio.self,
            Background.self,
            Blur.self,
            Clipped.self,
            CornerRadius.self,
            DrawingGroup.self,
            DynamicFrame.self,
            FontModifier.self,
            ForegroundColor.self,
            Frame.self,
            LayoutPriority.self,
            LifecycleModifier.self,
            Mask.self,
            NavigationBarTitle.self,
            Opacity.self,
            Padding.self,
            Shadow.self,
            Sheet.self,
        ]
    }

    var actions: [Action.Type] {
        [
            ComposedAction.self,
            CopyAction.self,
            SetAction<CoderView>.self,
            SetAction<Bool>.self,
            SetAction<Double>.self,
            SetAction<Float>.self,
            SetAction<Float32>.self,
            SetAction<Float64>.self,
            SetAction<Int>.self,
            SetAction<Int8>.self,
            SetAction<Int16>.self,
            SetAction<Int32>.self,
            SetAction<Int64>.self,
            SetAction<String>.self,
            SetAction<UInt8>.self,
            SetAction<UInt16>.self,
            SetAction<UInt32>.self,
            SetAction<UInt64>.self,
        ]
    }

}
