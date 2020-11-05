import React from "react";
import { mount } from "enzyme";
import CommentBox from "components/CommentBox";
import Root from "Root";

let wrapped;
beforeEach(() => {
  wrapped = mount(
    <Root>
      <CommentBox />
    </Root>
  );
});

afterEach(() => {
  wrapped.unmount();
});

// Verify the Areas and Button Exists
it("has text area and button", () => {
  expect(wrapped.find("textarea").length).toEqual(1);
  expect(wrapped.find("button").length).toEqual(1);
});

describe("Text Area", () => {
  beforeEach(() => {
    wrapped.find("textarea").simulate("change", {
      target: { value: "test comment" },
    });
    wrapped.update();
  });

  // Simulate change handler
  it("has a text area and able to type in", () => {
    // assertion
    expect(wrapped.find("textarea").prop("value")).toEqual("test comment");
  });

  // When button is clicked the form should be empty
  it("when form is submitted text area is empty", () => {
    expect(wrapped.find("textarea").prop("value")).toEqual("test comment");
    wrapped.find("form").simulate("submit");
    wrapped.update();
    expect(wrapped.find("textarea").prop("value")).toEqual("");
  });
});
