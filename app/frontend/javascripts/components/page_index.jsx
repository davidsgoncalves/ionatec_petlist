'use strict';

import React from 'react';
import Filters from './filters'
import TableComponent from './table_component'
import {Row} from 'react-bootstrap'

const PageIndex = React.createClass({
    render() {
        return (
            <div>
                <div className="container form-body">
                    <Filters breeds={this.props.breeds} path={this.props.path} token={this.props.token} params={this.props.params}/>
                </div>
                <div className="container form-body">
                    <TableComponent dogs={this.props.dogs}/>
                </div>
            </div>
        );
    }
});

export default PageIndex