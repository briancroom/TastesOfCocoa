import Cedar
import Nimble

class SwiftSpec: CDRSpec {
    override func declareBehaviors() {
        describe("running tests in Swift") {
            it("has passing tests") {
                expect(1).to(equal(1));
            }

            it("has failing tests too!") {
                expect(1).to(equal(2));
            }
        }
    }
}
