import XCTest

final class LunarAtlasUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testChapterNavigationAndPageControls() {
        let app = XCUIApplication()
        app.launch()

        let chapter = element("chapter-01", in: app)
        XCTAssertTrue(chapter.waitForExistence(timeout: 8))
        capture("cover", in: app)
        chapter.tap()
        XCTAssertTrue(app.navigationBars["認識月相"].exists)

        element("entry-new", in: app).tap()
        XCTAssertTrue(app.staticTexts["reader-title-new"].waitForExistence(timeout: 5))

        app.buttons["下一頁"].tap()
        let quarter = app.staticTexts["reader-title-quarter"]
        XCTAssertTrue(quarter.waitForExistence(timeout: 5))
        XCTAssertTrue(quarter.isHittable)

        element("reader-page-quarter", in: app).swipeLeft()
        let full = app.staticTexts["reader-title-full"]
        XCTAssertTrue(full.waitForExistence(timeout: 5))
        XCTAssertTrue(full.isHittable)
        XCTAssertFalse(app.buttons["下一頁"].isEnabled)

        let note = app.buttons.matching(identifier: "field-note-toggle").matching(NSPredicate(format: "hittable == true")).firstMatch
        if !note.exists {
            element("reader-page-full", in: app).swipeUp()
        }
        note.tap()
        XCTAssertTrue(app.staticTexts["field-note-text"].waitForExistence(timeout: 5))
        capture("reader", in: app)
        note.tap()
        XCTAssertFalse(app.staticTexts.matching(identifier: "field-note-text").matching(NSPredicate(format: "hittable == true")).firstMatch.exists)
    }

    func testGalleryNavigationAndLocalVideoPlayback() {
        let app = XCUIApplication()
        app.launch()

        app.buttons["圖鑑"].firstMatch.tap()
        let plate = element("plate-Craters", in: app)
        XCTAssertTrue(plate.waitForExistence(timeout: 5))
        capture("gallery", in: app)
        plate.tap()
        XCTAssertTrue(app.navigationBars["撞擊地形"].waitForExistence(timeout: 5))

        app.buttons["影片"].firstMatch.tap()
        let playback = app.buttons["film-playback"]
        XCTAssertTrue(playback.waitForExistence(timeout: 8))

        playback.tap()
        let playing = NSPredicate(format: "label == %@", "暫停影片")
        expectation(for: playing, evaluatedWith: playback)
        waitForExpectations(timeout: 6)
        capture("film", in: app)

        playback.tap()
        let paused = NSPredicate(format: "label == %@", "播放影片")
        expectation(for: paused, evaluatedWith: playback)
        waitForExpectations(timeout: 6)
    }

    private func capture(_ name: String, in app: XCUIApplication) {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    private func element(_ identifier: String, in app: XCUIApplication) -> XCUIElement {
        app.descendants(matching: .any).matching(identifier: identifier).firstMatch
    }
}
