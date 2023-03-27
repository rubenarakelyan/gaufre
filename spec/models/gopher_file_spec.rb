require "rails_helper"

RSpec.describe GopherFile do
  describe ".content" do
    context "when the file is a text file" do
      let(:subject) do
        GopherFile.new(
          filetype: "0",
          selector: "this/is/a/test.txt",
          resource: "This is the content of the file"
        )
      end

      it "returns the text content" do
        expect(subject.mime_type).to eq("text/plain")
        expect(subject.content).to eq("This is the content of the file")
      end
    end

    context "when the file is an image file" do
      let(:subject) do
        GopherFile.new(
          filetype: "p",
          selector: "this/is/a/test.png",
          resource: File.read(Rails.root.join("spec/fixtures/files/test.png"))
        )
      end

      it "returns the image content" do
        expect(subject.mime_type).to eq("image/png")
        expect(subject.content).to eq(File.read(Rails.root.join("spec/fixtures/files/test.png")))
      end

      context "when INLINE_IMAGES is true" do
        before do
          allow(ENV).to receive(:fetch).with("INLINE_IMAGES", "false").and_return("true")
        end

        it "returns the image content as a Base64 string" do
          expect(subject.content).to eq(Base64.encode64(File.read(Rails.root.join("spec/fixtures/files/test.png"))))
        end
      end
    end

    context "when the file is not a text or image file" do
      let(:subject) do
        GopherFile.new(
          filetype: ";",
          selector: "this/is/a/test.avi",
          resource: File.read(Rails.root.join("spec/fixtures/files/test.avi"))
        )
      end

      it "returns the file content" do
        expect(subject.mime_type).to eq("video/x-msvideo")
        expect(subject.content).to eq(File.read(Rails.root.join("spec/fixtures/files/test.avi")).force_encoding("ASCII-8BIT"))
      end
    end
  end
end
