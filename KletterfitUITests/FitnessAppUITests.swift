import XCTest

class FitnessAppUITests: XCTestCase {

    func testAddGoal() {
        let app = XCUIApplication()
        app.launch()

        let seeAllStatisticsButton = app.buttons["See all statistics"]
        XCTAssertTrue(seeAllStatisticsButton.exists)
        seeAllStatisticsButton.tap()

        let addGoalButton = app.buttons["Add goal"]
        XCTAssertTrue(addGoalButton.exists)
        addGoalButton.tap()

        let addNewGoalButton = app.buttons["Add new goal"]
        XCTAssertTrue(addNewGoalButton.exists)
        addNewGoalButton.tap()

        XCTAssertTrue(app.alerts["Successfully updated new goal"].exists)
    }
}
