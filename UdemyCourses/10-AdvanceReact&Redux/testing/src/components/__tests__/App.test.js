import React from "react";
import { shallow } from "enzyme";
import App from "components/App";
import CommentBox from "components/CommentBox";
import CommentList from "components/CommentList";

let wrapped_component;

beforeEach(() => {
  wrapped_component = shallow(<App />);
});

it("displays the CommentBox", () => {
  expect(wrapped_component.find(CommentBox).length).toEqual(1);
});

it("displays the CommentList", () => {
  expect(wrapped_component.find(CommentList).length).toEqual(1);
});
